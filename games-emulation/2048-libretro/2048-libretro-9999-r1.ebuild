# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3

DESCRIPTION="libretro implementation of 2048. (Puzzle game)"
HOMEPAGE="https://github.com/libretro/libretro-2048"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-2048.git"

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
	emake -f Makefile.libretro || die "emake failed"
}

src_install() {
	insinto ${GAMES_PREFIX}/$(get_libdir)/libretro
	doins "${S}"/2048_libretro.so
	insinto ${GAMES_DATADIR}/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/2048_libretro.info
	insinto ${GAMES_DATADIR}/libretro/2048_libretro
	doins "${S}"/COPYING
	prepgamesdirs
}
