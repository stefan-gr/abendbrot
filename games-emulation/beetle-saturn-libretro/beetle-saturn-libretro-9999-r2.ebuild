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
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "sega_101.bin (Saturn JP BIOS)"
		elog "mpr-17933.bin (Saturn US/EU BIOS)"
		elog "mpr-18811-mx.ic1 (The King of Fighters '95 ROM Cartridge)"
		elog "mpr-19367-mx.ic1 (Ultraman: Hikari no Kyojin Densetsu ROM Cartridge)"
		elog ""
		ewarn ""
	fi
}
