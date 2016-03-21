# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen VBA/GBA. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/beetle-gba-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-gba-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=mednafen_gba

src_compile() {
	emake core=gba || die "emake failed"
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
		elog "gba_bios.bin (GBA BIOS)"
		elog ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
