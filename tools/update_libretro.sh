#!/bin/bash
# This script updates all libretro cores and misc retroarch packages
# to the newest date. It downloads https://api.github.com/repos.
# Please note: this API has a rate limit of at least 60 requests per hour.
# It should be enough for this.

# Make sure we have the needed commands
command -v curl >/dev/null 2>&1 || { echo >&2 "Please install curl. Aborting."; exit 1; }

# Setting $SCRIPT_DIR variable to script directory.
SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "${SOURCE}" )"
while [ -h "${SOURCE}" ]
do 
	SOURCE="$(readlink "${SOURCE}")"
	[[ ${SOURCE} != /* ]] && SOURCE="${DIR}/${SOURCE}"
	DIR="$( cd -P "$( dirname "${SOURCE}"  )" && pwd )"
done
export SCRIPT_DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"

# Check for proper file structure.
if [ ! -f "${SCRIPT_DIR}/../games-emulation/4do-libretro/4do-libretro-9999-r1.ebuild" ]
then
	echo "Wrong directory, plese put this script in \${REPO_NAME}/tools"
	exit 1
fi

core_update() {
	local CORE_DIR="${@%/*}"
	local CORE_NAME="${@##*/}"
	# Assign repo uri for later use
	local `grep EGIT_REPO_URI= "${@}"`
	# Do some crude string expansion to get github abi uri.
	local EGIT_REPO_URI="${EGIT_REPO_URI:1:${#EGIT_REPO_URI}-2}"
	local EGIT_REPO_URI="${EGIT_REPO_URI/git:\/\//https:\/\/}"
	local EGIT_REPO_URI="${EGIT_REPO_URI/https:\/\/github.com/https:\/\/api.github.com\/repos}"
	local EGIT_REPO_URI="${EGIT_REPO_URI%.git}"
	# Do some crude string expansion to get latest commit date through github abi.
	local LATEST_COMMIT=$(curl -i "${EGIT_REPO_URI}" | grep pushed_at | head -1)
	if [[ -z "${LATEST_COMMIT}" ]]
	then
		echo -e "\e[31mFetching repo information failed. Rate limit probably exceeded, wait 1 hour\e[0m"
		echo -e "\e[31mTry 'curl -i \"${EGIT_REPO_URI}\"'\e[0m"
		echo -e "\e[31mTo see what problem it is.\e[0m"
		exit 1
	fi
	local LATEST_COMMIT="${LATEST_COMMIT##* }"
	local LATEST_COMMIT="${LATEST_COMMIT:1:10}"
	# Need to add a day because git-r3 only fetches the previous day
	LC_ALL=C local LATEST_COMMIT=$(date --date="${LATEST_COMMIT} + next day" +%Y-%m-%d)
	# This is the latest version name
	local LATEST_COMMIT_VERSION="${LATEST_COMMIT:0:4}${LATEST_COMMIT:5:2}${LATEST_COMMIT:8:2}"
	local NEW_EBUILD="${CORE_DIR}/${CORE_NAME%%-9*}-1.0_pre${LATEST_COMMIT_VERSION}.ebuild"
	if [ -f "${NEW_EBUILD}" ]
	then
		echo -e "\e[92m\"${NEW_EBUILD}\" already up-to-date.\e[0m"
		return
	else
		echo -e "\e[92mCreating \"${NEW_EBUILD}\"\e[0m"
		cd "${CORE_DIR}"
		ln -s "${CORE_NAME}" "${NEW_EBUILD##*/}"
	fi
}

# Collect all needed files and send them to core_update
for core in "${SCRIPT_DIR}/../games-emulation/"*libretro*/*-9999*
do
	# Skip libretro-meta package
	[[ $core == *"libretro-meta"* ]] && continue
	core_update "${core}"
done
# Didn't catch them above
core_update "${SCRIPT_DIR}/../games-emulation/retroarch-assets/retroarch-assets-9999-r1.ebuild"
core_update "${SCRIPT_DIR}/../games-emulation/retroarch-joypad-autoconfig/retroarch-joypad-autoconfig-9999-r1.ebuild"
