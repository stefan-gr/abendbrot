# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="041856ec88ca75eca12ed9ef1afcc22e1220905f"
inherit libretro

DESCRIPTION="Collection of overlay files for use with libretro frontends."
HOMEPAGE="https://github.com/libretro/common-overlays"
KEYWORDS="amd64 x86 arm"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/overlays
	cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}"/overlays
}
