# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="467a0ccf48b6d507ce4fd3b61eac3936c46d2a20"
inherit libretro

DESCRIPTION="RetroArch Assets files"
HOMEPAGE="https://github.com/libretro/retroarch-assets"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${RETROARCH_DATA_DIR}"/assets
	cp -R "${S}"/* "${D}${RETROARCH_DATA_DIR}"/assets
}
