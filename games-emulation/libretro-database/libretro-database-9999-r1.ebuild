# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3

DESCRIPTION="Repository containing cheatcode files, content data files, etc. "
HOMEPAGE="https://github.com/libretro/libretro-database"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-database.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir ${GAMES_DATADIR}/libretro/cheats/
	cp -R "${S}"/cht/* "${D}"${GAMES_DATADIR}/libretro/cheats/
	dodir ${GAMES_DATADIR}/libretro/data/
	cp -R "${S}"/dat/* "${D}"${GAMES_DATADIR}/libretro/data/
	prepgamesdirs
}
