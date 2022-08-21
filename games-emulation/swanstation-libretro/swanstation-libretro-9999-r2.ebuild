# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core cmake-utils

DESCRIPTION="libretro implementation of Swanstation, a fork of duckstation. (PlayStation)"
HOMEPAGE="https://github.com/libretro/swanstation"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_configure() {
	local mycmakeargs=(
		-DBUILD_LIBRETRO_CORE=ON
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
}

src_install() {
	LIBRETRO_CORE_LIB_FILE="${WORKDIR}/${P}_build/${LIBRETRO_CORE_NAME}_libretro.so"
	libretro-core_src_install
}
