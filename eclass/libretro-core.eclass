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
# "${WORKDIR}/infos/dist/info/${LIBRETRO_CORE_NAME}_libretro.info".
LIBRETRO_CORE_INFO_FILE=

# @ECLASS-VARIABLE: LIBRETRO_CORE_LIB_FILE
# @DESCRIPTION:
# Absolute path of this Libretro core's shared library. Defaults to
# "${S}/${LIBRETRO_CORE_NAME}_libretro.so".
LIBRETRO_CORE_LIB_FILE=

EXPORT_FUNCTIONS src_unpack src_install

#FIXME: The core info repository is fairly large, and currently duplicated
#between every "*-libretro" core ebuild. Ideally, we should probably just
#install this repository as a separate ebuild and then have all "*-libretro"
#core ebuilds depend upon that ebuild.

# @FUNCTION: libretro-core_src_unpack
# @DESCRIPTION:
# The libretro-core src_unpack function which is exported.
#
# This function retrieves the remote Libretro core info database.
libretro-core_src_unpack() {
	# Retrieve the remote Libretro core info database.
	git-r3_fetch \
		https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout \
		https://github.com/libretro/libretro-super.git "${WORKDIR}"/infos

	# Absolute path of this Libretro core's info file, deferred until the child
	# ebuild has had the opportunity to redefine ${LIBRETRO_CORE_NAME}.
	[[ -n "${LIBRETRO_CORE_INFO_FILE}" ]] ||
		LIBRETRO_CORE_INFO_FILE="${WORKDIR}"/infos/dist/info/"${LIBRETRO_CORE_NAME}"_libretro.info

	# Absolute path of this Libretro core's shared library, deferred until the
	# child ebuild has had the opportunity to redefine ${LIBRETRO_CORE_NAME}
	[[ -n "${LIBRETRO_CORE_LIB_FILE}" ]] ||
		LIBRETRO_CORE_LIB_FILE="${S}/${LIBRETRO_CORE_NAME}"_libretro.so

	# If this core's info file does *NOT* exist in this database, fail. This
	# core is unrecognized and likely to produce issues "down the road."
	[[ -f "${LIBRETRO_CORE_INFO_FILE}" ]] ||
		die "Libretro core \"${LIBRETRO_CORE_NAME}\" unrecognized: info file \"${LIBRETRO_CORE_INFO_FILE}\" not found." 

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
	doins "${LIBRETRO_CORE_INFO_FILE}"

	# If this core's shared library exists, install that.
	if [[ -f "${LIBRETRO_CORE_LIB_FILE}" ]]; then
		insinto "${LIBRETRO_LIB_DIR}"
		doins "${LIBRETRO_CORE_LIB_FILE}"
	else
		# Basename of this library.
		local lib_basename="${LIBRETRO_CORE_LIB_FILE##*/}"

		# Absolute path to which this library was installed.
		local lib_file_target="${ED}${LIBRETRO_LIB_DIR}/${lib_basename}"

		# If this library was *NOT* installed, fail.
		[[ -f "${lib_file_target}" ]] ||
			die "Libretro core shared library \"${lib_file_target}\" not installed."
	fi

	# Enforce games-specific permissions and ownership. 
	prepgamesdirs
}
