# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="0ed1e38c56899a73d74e064dd1ae9bdcc4f4af23"
inherit libretro

DESCRIPTION="Repository containing cheatcode files, content data files, etc."
HOMEPAGE="https://github.com/libretro/libretro-database"
KEYWORDS="~amd64 ~x86"

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
