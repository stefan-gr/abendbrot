# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="c376bb5890be158a148315c5bea65f73095b5364"
inherit libretro

DESCRIPTION="glsl shaders converted by hand from libretro's common-shaders repo"
HOMEPAGE="https://github.com/libretro/glsl-shaders"
KEYWORDS="amd64 x86"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="!<=games-emulation/common-shaders-1.0_pre20170426"
DEPEND="${RDEPEND}"

src_install() {
	dodir "${LIBRETRO_DATA_DIR}"/shaders
	# Remove unnecessary git files
	[[ ! ${PV} == "1.0_pre"* ]] && rm -r .git
	cp -R "${S}"/* "${D}${LIBRETRO_DATA_DIR}"/shaders/
}
