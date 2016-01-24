# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3

DESCRIPTION="Collection of commonly used Cg shaders."
HOMEPAGE="https://github.com/libretro/common-shaders"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/common-shaders.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir ${GAMES_DATADIR}/libretro/shaders/
	cp -R "${S}"/* "${D}"${GAMES_DATADIR}/libretro/shaders/
	prepgamesdirs
}
