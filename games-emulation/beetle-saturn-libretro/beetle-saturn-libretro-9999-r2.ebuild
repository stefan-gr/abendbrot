# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libretro-core

DESCRIPTION="Standalone port of Mednafen Saturn to the libretro"
HOMEPAGE="https://github.com/libretro/beetle-saturn-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_setup() {
	LIBRETRO_CORE_NAME="mednafen_saturn"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "sega_101.bin md5sum = 85ec9ca47d8f6807718151cbcca8b964"
		ewarn "mpr-17933.bin md5sum = 3240872c70984b6cbfda1586cab68dbe"
		ewarn "mpr-18811-mx.ic1 md5sum = 255113ba943c92a54facd25a10fd780c"
		ewarn "mpr-19367-mx.ic1 md5sum = 1cd19988d1d72a3e7caa0b73234c96b4"
		ewarn ""
		ewarn ""
	fi
}
