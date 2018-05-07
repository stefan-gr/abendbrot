# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="bdc2a82d1f9bcbe8dab608a893cf4d88e091f58d"
inherit libretro-core

DESCRIPTION="libretro implementation of prosystem. (Atari 7800)"
HOMEPAGE="https://github.com/libretro/prosystem-libretro"
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
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "ProSystem.dat (Atari 7800 Database)"
		ewarn "7800 BIOS (U).rom (Atari 7800 BIOS)"
		ewarn ""
		ewarn ""
	fi
}
