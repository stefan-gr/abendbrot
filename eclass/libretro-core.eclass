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

# Workaround for ppsspp
if [[ ! ${PV} == "1.0_pre"* ]] || [[ ${PN} == "psp1-libretro" ]] || [[ ${PN} == "ppsspp-libretro" ]]; then
	inherit git-r3 libretro
else
	inherit libretro
fi

# @ECLASS-VARIABLE: LIBRETRO_CORE_NAME
# @DESCRIPTION:
# Name of this Libretro core. The libretro-core_src_install() phase function
# will install the shared library "${S}/${LIBRETRO_CORE_NAME}_libretro.so" as a
# Libretro core. Defaults to the name of the current package excluding the
# "-libretro" suffix (e.g., "mgba" for the package "mgba-libretro").
: ${LIBRETRO_CORE_NAME:=${PN%-libretro}}

# @ECLASS-VARIABLE: LIBRETRO_CORE_LIB_FILE
# @DESCRIPTION:
# Absolute path of this Libretro core's shared library. Defaults to
# "${S}/${LIBRETRO_CORE_NAME}_libretro.so".
LIBRETRO_CORE_LIB_FILE=

EXPORT_FUNCTIONS src_unpack src_install

# @FUNCTION: libretro-core_src_unpack
# @DESCRIPTION:
# The libretro-core src_unpack function which is exported.
#
# This function retrieves the remote Libretro core info files.
libretro-core_src_unpack() {
	# Absolute path of this Libretro core's shared library, deferred until the
	# child ebuild has had the opportunity to redefine ${LIBRETRO_CORE_NAME}
	[[ -n "${LIBRETRO_CORE_LIB_FILE}" ]] ||
		LIBRETRO_CORE_LIB_FILE=()
		for i in "${LIBRETRO_CORE_NAME[@]}"
		do
			LIBRETRO_CORE_LIB_FILE+=( "${S}/${i}"_libretro.so )
		done

	# If this is a live ebuild, retrieve this core's remote repository.
	# Workaround for ppsspp
	if [[ ! ${PV} == "1.0_pre"* ]] || [[ ${PN} == "psp1-libretro" ]] || [[ ${PN} == "ppsspp-libretro" ]]; then
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
# This function installs the shared library for this Libretro core.
libretro-core_src_install() {
	# Absolute path of the directory containing Libretro shared libraries.
	LIBRETRO_LIB_DIR="${EROOT}usr/$(get_libdir)/libretro"
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
}
