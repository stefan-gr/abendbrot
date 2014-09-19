# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of PocketSNES."
HOMEPAGE="https://github.com/ToadKing/pocketsnes-libretro"
SRC_URI=""

EGIT_REPO_URI="git://github.com/ToadKing/pocketsnes-libretro.git"

LICENSE="PS"
SLOT="0"
KEYWORDS=""
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

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/pocketsnes_libretro.so
	doins "${WORKDIR}"/infos/dist/info/pocketsnes_libretro.info
}
