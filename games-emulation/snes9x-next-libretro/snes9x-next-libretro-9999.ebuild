# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of SNES9x Next. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/snes9x-next"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/snes9x-next.git"

LICENSE="snes9x"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD 
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_checkout
}

src_compile() {
	emake -f Makefile.libretro
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/snes9x_next_libretro.so
	doins "${WORKDIR}"/infos/dist/info/snes9x_next_libretro.info
	insinto /usr/share/libretro/snes9x_next_libretro
	doins "${S}"/docs/snes9x-license.txt
}
