# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="a272864e518b9d990ade62cb22c165558ab0f5d5"
inherit libretro-core

DESCRIPTION="libretro implementation of PX68K. (Sharp X68000)"
HOMEPAGE="https://github.com/libretro/px68k-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "This core needs the following files in the \"'system_directory'/keropi\" directory"
		ewarn "iplrom.dat (X68000 BIOS)"
		ewarn "cgrom.dat (X68000 BIOS 2)"
		ewarn ""
		elog ""
		elog "Optional:"
		elog "iplrom30.dat (X68000 BIOS 3)"
		elog ""
		elog "They can be legally acquired from:"
		elog "http://www.gradiushomeworld.co.uk/guides_emulators_x68_winx68khighspeed_guide.php"
		elog ""
	fi
}
