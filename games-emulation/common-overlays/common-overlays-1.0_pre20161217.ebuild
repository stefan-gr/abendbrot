# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="fd6179f39bda223ddbe5d747ebb3827923a5aaae"
inherit libretro

DESCRIPTION="Collection of overlay files for use with libretro frontends."
HOMEPAGE="https://github.com/libretro/common-overlays"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/overlays
	cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}"/overlays
}
