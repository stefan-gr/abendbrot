# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: libretro-core.eclass
# @MAINTAINER:
# leycec@gmail.com
# @AUTHOR:
# Original author: Cecil Curry
# @BLURB: An eclass to streamline the construction of Libretro core ebuilds
# @DESCRIPTION:
# The libretro eclass is designed to streamline the construction of
# ebuilds for low-level Libretro core ebuilds.

inherit git-r3 libretro

# @ECLASS-VARIABLE: LIBRETRO_CORE_NAME
# @DESCRIPTION:
# Name of this Libretro core. The libretro-core_src_install() phase function
# will install the shared library "${S}/${LIBRETRO_CORE_NAME}_libretro.so" as a
# Libretro core. Defaults to the name of the current package excluding the
# "-libretro" suffix (e.g., "mgba" for the package "mgba-libretro").
: ${LIBRETRO_CORE_NAME:=${PN%-libretro}}

# @ECLASS-VARIABLE: LIBRETRO_CORE_INFO_FILE
# @DESCRIPTION:
# Absolute path of this Libretro core's info file. Defaults to
# "${WORKDIR}/${LIBRETRO_CORE_NAME}_libretro.info".
LIBRETRO_CORE_INFO_FILE=

# @ECLASS-VARIABLE: LIBRETRO_CORE_LIB_FILE
# @DESCRIPTION:
# Absolute path of this Libretro core's shared library. Defaults to
# "${S}/${LIBRETRO_CORE_NAME}_libretro.so".
LIBRETRO_CORE_LIB_FILE=

EXPORT_FUNCTIONS src_unpack src_install

#FIXME: The core info files get downloaded anew constantly.
#A seperate ebuild would require constant use flag changes
#or all info files get installed without the cores available.
#Putting them in SRC_URI would require constant manifest updates,
#which doesn't work without upstream releasing versioned info files.
#I guess this is a good compromise until we can exclude manifest checks
#in SRC_URI.

# @FUNCTION: libretro-core_src_unpack
# @DESCRIPTION:
# The libretro-core src_unpack function which is exported.
#
# This function retrieves the remote Libretro core info files.
libretro-core_src_unpack() {
	# Retrieve this Libretro core's info files from the libretro buildbot
	for i in "${LIBRETRO_CORE_NAME[@]}"
	do
		wget http://buildbot.libretro.com/assets/frontend/info/"${i}"_libretro.info
	done

	# Absolute path of this Libretro core's info file, deferred until the child
	# ebuild has had the opportunity to redefine ${LIBRETRO_CORE_NAME}.
	[[ -n "${LIBRETRO_CORE_INFO_FILE}" ]] ||
		LIBRETRO_CORE_INFO_FILE=()
		for i in "${LIBRETRO_CORE_NAME[@]}"
		do
			LIBRETRO_CORE_INFO_FILE+=( "${WORKDIR}/${i}"_libretro.info )
		done

	# Absolute path of this Libretro core's shared library, deferred until the
	# child ebuild has had the opportunity to redefine ${LIBRETRO_CORE_NAME}
	[[ -n "${LIBRETRO_CORE_LIB_FILE}" ]] ||
		LIBRETRO_CORE_LIB_FILE=()
		for i in "${LIBRETRO_CORE_NAME[@]}"
		do
			LIBRETRO_CORE_LIB_FILE+=( "${S}/${i}"_libretro.so )
		done

	# If this core's info file does *NOT* exist in this database, fail. This
	# core is unrecognized and likely to produce issues "down the road."
	for i in "${LIBRETRO_CORE_INFO_FILE[@]}"
	do
		[[ -f "${i}" ]] ||
			die "Libretro core \"${LIBRETRO_CORE_NAME}\" unrecognized: info file \"${i}\" not found."
	done

	# If this is a live ebuild, retrieve this core's remote repository.
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	# Else, unpack this core's local tarball.
	else
		default_src_unpack
	fi
}

# @FUNCTION: libretro-core_src_install
# @DESCRIPTION:
# The libretro-core src_install function which is exported.
#
# This function installs the shared library and info files for this Libretro
# core.
libretro-core_src_install() {
	# Install this core's info file.
	insinto "${LIBRETRO_DATA_DIR}"/info
	for i in "${LIBRETRO_CORE_INFO_FILE[@]}"
	do
		doins "${i}"
	done

	# If this core's shared library exists, install that.
	for i in "${LIBRETRO_CORE_LIB_FILE[@]}"
	do
		if [[ -f "${i}" ]]; then
			insinto "${LIBRETRO_LIB_DIR}"
			doins "${i}"
		else
			# Basename of this library.
			local lib_basename="${i##*/}"

			# Absolute path to which this library was installed.
			local lib_file_target="${ED}${LIBRETRO_LIB_DIR}/${lib_basename}"

			# If this library was *NOT* installed, fail.
			[[ -f "${lib_file_target}" ]] ||
				die "Libretro core shared library \"${lib_file_target}\" not installed."
		fi
	done

	# Enforce games-specific permissions and ownership.
	prepgamesdirs
}
