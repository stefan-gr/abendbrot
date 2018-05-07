#!/bin/bash
# Make sure we have the needed commands
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
	echo "Wrong directory, please put this script in \${REPO_NAME}/tools"
	exit 1
fi

# Put them arm tested ebuilds here
ARM_LIST=( ppsspp-libretro psp1-libretro vba-next-libretro common-overlays )
AMD64_LIST=( dolphin-libretro )


make_stable() {
	shopt -s nullglob
	local EBUILDS=("${@}"*_pre*.ebuild)
	[ "${#EBUILDS[@]}" -le 2 ] && return
	# Keep the most two recent EBUILDS and just declare the oldest one stable
	local KEEP_EBUILDS=( $({ [ "${#EBUILDS[@]}" -eq 0 ] || printf '%s\n' "${EBUILDS[@]}"; } | tail -n 2) )
	local DELETE_EBUILDS=( $({ [ "${#EBUILDS[@]}" -eq 0 ] || printf '%s\n' "${EBUILDS[@]}"; } | head -n $((${#EBUILDS[@]}-2))) )
	local ARM_ENABLED=0
	local AMD64_ENABLED=0
	for i in ${ARM_LIST[@]}; do
		[ "$i" == "$(basename ${@})" ] && ARM_ENABLED=1
	done
	for i in ${AMD64_LIST[@]}; do
		[ "$i" == "$(basename ${@})" ] && AMD64_ENABLED=1
	done

	if [ "${ARM_ENABLED}" == "1" ]; then
		sudo sed -i 's,^KEYWORDS=".*",KEYWORDS="amd64 x86 arm",g' "${KEEP_EBUILDS[0]}"
	elif [ "${AMD64_ENABLED}" == "1" ]; then
		sudo sed -i 's,^KEYWORDS=".*",KEYWORDS="amd64",g' "${KEEP_EBUILDS[0]}"
	else
		sudo sed -i 's,^KEYWORDS=".*",KEYWORDS="amd64 x86",g' "${KEEP_EBUILDS[0]}"
	fi

	for item in "${DELETE_EBUILDS[@]}"; do
		rm "${item}"
	done
	shopt -u nullglob
}

if [ -z "$1" ]
then
	# Collect all needed files and send them to make_stable
	for directory in "${SCRIPT_DIR}/../games-emulation/"*libretro*/
	do
		# Skip libretro-meta package
		[[ $directory == *"libretro-meta"* ]] && continue
		make_stable "${directory}"
	done
	# Didn't catch them above
	make_stable "${SCRIPT_DIR}/../games-emulation/retroarch-assets/"
	make_stable "${SCRIPT_DIR}/../games-emulation/retroarch-joypad-autoconfig/"
	make_stable "${SCRIPT_DIR}/../games-emulation/common-overlays/"
	make_stable "${SCRIPT_DIR}/../games-emulation/common-shaders/"
	make_stable "${SCRIPT_DIR}/../games-emulation/glsl-shaders/"
	make_stable "${SCRIPT_DIR}/../games-emulation/slang-shaders/"
else
	make_stable "${@}"
fi

cd ../games-emulation
repoman manifest
cd ../tools
