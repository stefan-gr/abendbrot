# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3

DESCRIPTION="libretro implementation of MAME 2014. (Arcade)"
HOMEPAGE="https://github.com/libretro/mame"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/mame.git"

LICENSE="MAME-GPL"
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
	doins "${S}"/mame_libretro.so
	insinto ${GAMES_DATADIR}/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/mame_libretro.info
	insinto ${GAMES_DATADIR}/libretro/mame_libretro
	doins "${S}"/docs/mamelicense.txt
	prepgamesdirs
}
