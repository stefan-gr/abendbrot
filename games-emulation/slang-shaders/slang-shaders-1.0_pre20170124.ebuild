# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="ef130f1a00e6e84143efa76a7f6f27f907aab168"
inherit libretro

DESCRIPTION="Collection of slang shaders for vulkan backends."
HOMEPAGE="https://github.com/libretro/slang-shaders"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/"${PN}"
	# Remove unnecessary git files
	[[ ! ${PV} == "1.0_pre"* ]] && rm -r .git
	cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}"/"${PN}"/
}
