# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of mupen64plus (Nintendo64)"
HOMEPAGE="https://github.com/libretro/mednafen-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/${PN}.git"

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
	use amd64 && emake WITH_DYNAREC=x86_64
	use x86 && emake WITH_DYNAREC=x86
	use arm && emake platform=rpi WITH_DYNAREC=arm
	use arm64 && emake platform=rpi WITH_DYNAREC=arm
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/mupen64plus_libretro.so
	doins "${WORKDIR}"/infos/dist/info/mupen64plus_libretro.info
}
