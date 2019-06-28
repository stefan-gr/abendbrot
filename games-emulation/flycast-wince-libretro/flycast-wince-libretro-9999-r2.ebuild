# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/flycast"
EGIT_BRANCH="fh/wince"
inherit libretro-core

DESCRIPTION="libretro implementation of Flycast WinCE, a fork of Reicast. (Sega Dreamcast/NAOMI/Atomiswave)"
HOMEPAGE="https://github.com/libretro/flycast"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="+oit"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

LIBRETRO_CORE_NAME=flycast_wince

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

src_prepare() {
	libretro-core_src_prepare
	#fixing ARCH detection
	sed -i Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die '"sed" failed'
}

src_compile() {
	if use oit; then
		myemakeargs+=( "HAVE_OIT=1" )
	fi
	libretro-core_src_compile
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory/dc' folder:"
		elog "dc_boot.bin (Dreamcast BIOS)"
		elog "dc_flash.bin (Date/Time/Language)"
		elog "naomi.zip (Naomi Bios from MAME)"
		elog "hod2bios.zip (Naomi The House of the Dead 2 Bios from MAME)"
		elog "f355dlx.zip (Naomi Ferrari F355 Challenge deluxe Bios from MAME)"
		elog "f355bios.zip (Naomi Ferrari F355 Challenge twin/deluxe Bios from MAME)"
		elog "airlbios.zip (Naomi Airline Pilots deluxe Bios from MAME)"
		elog "awbios.zip (Atomiswave BIOS from MAME)"
		ewarn ""
	fi
}
