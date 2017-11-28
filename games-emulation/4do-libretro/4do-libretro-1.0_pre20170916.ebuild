# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="d2c91928d6e434160d9fc25c7b7e0d3da4391bea"
inherit libretro-core

DESCRIPTION="libretro implementation of 4DO/libfreedo. (Panasonic 3DO)"
HOMEPAGE="https://github.com/libretro/4do-libretro"
KEYWORDS="amd64 x86"

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
		ewarn "You need to have the following file in your 'system_directory' folder:"
		ewarn "panafz10.bin (Panasonic FZ-10 BIOS)"
		ewarn ""
		ewarn ""
	fi
}
