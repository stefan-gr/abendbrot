# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of Mednafen VBA/GBA. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/beetle-gba-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-gba-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	emake core=gba || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/mednafen_gba_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/mednafen_gba_libretro.info
}

pkg_postinst() {
	elog ""
	elog "This emulator can use a bios file in your 'system_directory'"
	elog "otherwise some games will not work. Please place it in the following directory:"
	elog "~/.local/share/retroarch/system/"
	elog ""
	elog "Here is a list with optional files:"
	elog "gba_bios.bin (GBA BIOS)"
	elog ""
}
