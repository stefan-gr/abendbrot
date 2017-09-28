# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="b1edf45cb6226bd282e2609e55bbde28c5d389f2"
inherit libretro

DESCRIPTION="RetroArch Assets files"
HOMEPAGE="https://github.com/libretro/retroarch-assets"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${RETROARCH_DATA_DIR}"/assets
	cp -R "${S}"/* "${D}${RETROARCH_DATA_DIR}"/assets
}
