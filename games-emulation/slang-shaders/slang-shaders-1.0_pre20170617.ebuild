# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="04996b80ccf50d608d6adf6f831981edf72b989f"
inherit libretro

DESCRIPTION="Collection of slang shaders for vulkan backends."
HOMEPAGE="https://github.com/libretro/slang-shaders"
KEYWORDS="~amd64 ~x86"

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
