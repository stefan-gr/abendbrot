# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

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
	dodir /usr/share/libretro/cheats/
	cp -R "${S}"/cht/* "${D}"/usr/share/libretro/cheats/
	dodir /usr/share/libretro/data/
	cp -R "${S}"/dat/* "${D}"/usr/share/libretro/data/
}
