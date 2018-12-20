# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/Ishiiruka"
inherit libretro-core cmake-utils

DESCRIPTION="libretro implementation of Ishiiruka. (Nintendo GC/Wii)"
HOMEPAGE="https://github.com/libretro/Ishiiruka"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_configure() {
	local mycmakeargs=(
		-DLIBRETRO="ON"
	)
	cmake-utils_src_configure
}

src_install() {
	LIBRETRO_CORE_LIB_FILE="${WORKDIR}/${P}_build/${LIBRETRO_CORE_NAME}_libretro.so"
	libretro-core_src_install
}
