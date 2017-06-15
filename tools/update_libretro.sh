#!/bin/bash
# This script updates all libretro cores and misc retroarch packages
# to the newest date. It downloads https://api.github.com/repos.
# Please note: this API has a rate limit of at least 60 requests per hour.
# It should be enough for this provided not every single core needs to be updated.

#TODO: Fix ebuilds not cantaining *libretro*, they update without proper commit check
#TODO: See line #46 for culprit

# Make sure we have the needed commands
command -v curl >/dev/null 2>&1 || { echo >&2 "Please install net-misc/curl. Aborting."; exit 1; }
command -v sudo >/dev/null 2>&1 || { echo >&2 "Please install app-admin/sudo and add your user to it. Aborting."; exit 1; }

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
if [ ! -f "${SCRIPT_DIR}/../games-emulation/fbalpha2012-libretro/fbalpha2012-libretro-9999-r2.ebuild" ]
then
	echo "Wrong directory, plese put this script in \${REPO_NAME}/tools"
	exit 1
fi

core_update() {
	CORE_DIR="${@%/*}"
	CORE_NAME="${@##*/}"
	export LC_ALL=C
	export TZ=GMT

	# Do some crude string expansion to get github abi uri.
	local `grep HOMEPAGE= "${@}"`
	local EGIT_URI="${HOMEPAGE:1:${#HOMEPAGE}-2}"
	local EGIT_URI="${EGIT_URI/git:\/\//https:\/\/}"
	local EGIT_COMMITS_URI="${EGIT_URI/https:\/\/github.com/https:\/\/api.github.com\/repos}"
	local EGIT_COMMITS_URI="${EGIT_COMMITS_URI}/commits"

	# Check for latest ebuild date and use it as a base to get the latest commit.
	local EGIT_CURRENT_DATE=$(for n in "${CORE_DIR}"/*libretro*
	do
		[[ $n == *"9999"* ]] && continue
		echo "$n"
	done | sort | tail -1)
	echo "${EGIT_CURRENT_DATE}"
	exit 1
	if [[ -z "${EGIT_CURRENT_DATE}" ]]
	then
		local LATEST_COMMIT_CURL=$(curl -i "${EGIT_COMMITS_URI}")
	else
		local EGIT_CURRENT_DATE=$(sed 's/^.*\([0-9]\{8\}\).*$/\1/' <<< "${EGIT_CURRENT_DATE}")
		# Do some crude string expansion to get latest commit date and sha sum through github abi.
		local LATEST_COMMIT_CURL=$(curl -i "${EGIT_COMMITS_URI}" -H "If-Modified-Since: $(date --date="${EGIT_CURRENT_DATE} 23:59:59" +"%a, %d %b %Y %H:%M:%S %Z")")
		[[ "${LATEST_COMMIT_CURL}" == *"304 Not Modified"* ]] && echo -e "\e[33m\"${CORE_NAME%%-9*}-1.0_pre${EGIT_CURRENT_DATE}\" already up-to-date.\e[0m" && return
	fi
	local LATEST_COMMIT_DATE=$(echo "${LATEST_COMMIT_CURL}" | grep date | head -1)
	local LATEST_COMMIT_SHA=$(echo "${LATEST_COMMIT_CURL}" | grep sha | head -1)
	# Strip the variables of junk
	local LATEST_COMMIT_DATE="${LATEST_COMMIT_DATE##* }"
	local LATEST_COMMIT_DATE="${LATEST_COMMIT_DATE:1:10}"
	local LATEST_COMMIT_SHA="${LATEST_COMMIT_SHA##* }"
	local LATEST_COMMIT_SHA="${LATEST_COMMIT_SHA:1:40}"
	# Check if the variables are empty or not
	if [[ -z "${LATEST_COMMIT_DATE}" ]] && [[ -z "${LATEST_COMMIT_SHA}" ]]
	then
		echo -e "\e[31mFetching repo information failed. Rate limit probably exceeded, wait 1 hour\e[0m"
		echo -e "\e[31mTry 'curl -i \"${EGIT_COMMITS_URI}\"'\e[0m"
		echo -e "\e[31mTo see what problem it is.\e[0m"
		return
	fi
	# Prepare ebuild name and path
	local LATEST_COMMIT_DATE_VERSION="${LATEST_COMMIT_DATE:0:4}${LATEST_COMMIT_DATE:5:2}${LATEST_COMMIT_DATE:8:2}"
	local MY_P="${CORE_NAME%%-9*}-1.0_pre${LATEST_COMMIT_DATE_VERSION}"
	local NEW_EBUILD="${CORE_DIR}/${MY_P}.ebuild"
	if [ -f "${NEW_EBUILD}" ]
	then
		echo -e "\e[33m\"${NEW_EBUILD}\" already up-to-date.\e[0m"
		return
	else
		echo -e "\e[92mCreating \"${NEW_EBUILD}\"\e[0m"
		cd "${CORE_DIR}"
		sudo cp "${CORE_NAME}" "${NEW_EBUILD##*/}"
		sudo sed -i 's,^inherit,LIBRETRO_COMMIT_SHA="'${LATEST_COMMIT_SHA}'"\ninherit,g' "${NEW_EBUILD##*/}" || exit 1
		sudo sed -i 's,^KEYWORDS="",KEYWORDS="~amd64 ~x86",g' "${NEW_EBUILD##*/}" || exit 1
		# Never forget the manifest
		sudo ebuild --force "${NEW_EBUILD##*/}" manifest
	fi
}

if [ -z "$1" ]
then
	# Collect all needed files and send them to core_update
	for core in "${SCRIPT_DIR}/../games-emulation/"*libretro*/*-9999*
	do
		# Skip libretro-meta package
		[[ $core == *"libretro-meta"* ]] && continue
		core_update "${core}"
	done
	# Didn't catch them above
	core_update "${SCRIPT_DIR}/../games-emulation/retroarch-assets/retroarch-assets-9999-r2.ebuild"
	core_update "${SCRIPT_DIR}/../games-emulation/retroarch-joypad-autoconfig/retroarch-joypad-autoconfig-9999-r2.ebuild"
	core_update "${SCRIPT_DIR}/../games-emulation/common-overlays/common-overlays-9999-r2.ebuild"
	core_update "${SCRIPT_DIR}/../games-emulation/common-shaders/common-shaders-9999-r2.ebuild"
	core_update "${SCRIPT_DIR}/../games-emulation/glsl-shaders/glsl-shaders-9999-r2.ebuild"
	core_update "${SCRIPT_DIR}/../games-emulation/slang-shaders/slang-shaders-9999-r2.ebuild"
else
	core_update "${@}"
fi
