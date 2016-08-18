# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro

DESCRIPTION="Repository containing cheatcode files, content data files, etc."
HOMEPAGE="https://github.com/libretro/libretro-database"
SRC_URI="https://github.com/libretro/libretro-database/archive/bfad2689494f3fbc8a1d82feb957dbea5f386034.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/libretro-database-bfad2689494f3fbc8a1d82feb957dbea5f386034"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/libretro/libretro-database.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/cheats/
	cp -R "${S}"/cht/* "${D}${LIBRETRO_DATA_DIR}"/cheats/
	dodir "${LIBRETRO_DATA_DIR}"/data/
	cp -R "${S}"/dat/* "${D}${LIBRETRO_DATA_DIR}"/data/
	cp -R "${S}"/rdb/* "${D}${LIBRETRO_DATA_DIR}"/data/
}
