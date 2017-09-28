# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="1b58f2e9e4c4973c1bf6a63c5d38c160e682141a"
inherit libretro

DESCRIPTION="Collection of commonly used Cg shaders."
HOMEPAGE="https://github.com/libretro/common-shaders"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}/${PN}/"
	# Remove unnecessary git files
	[[ ! ${PV} == "1.0_pre"* ]] && rm -r .git
	# Install plain CG shaders
	cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}/${PN}/"
}
