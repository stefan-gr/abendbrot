# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="e728359623d29191da7186ca7eaee70862a0174f"
# These are used by citra and externals/dynarmic which seems to break with git-r3.eclass
EGIT_SUBMODULES=("*" "-externals/fmt" "-externals/xbyak")
inherit libretro-core cmake-utils

DESCRIPTION="libretro implementation of Citra. (Nintendo 3DS)"
HOMEPAGE="https://github.com/libretro/citra"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

RDEPEND="virtual/opengl
	media-libs/libpng:=
	sys-libs/zlib
	media-libs/libsdl2
	"
DEPEND="${DEPEND}"


src_configure() {
	local mycmakeargs=(
		-DENABLE_LIBRETRO="ON"
		-DENABLE_QT="OFF"
		-DENABLE_SDL2="OFF"
	)
	cmake-utils_src_configure
}

src_install() {
	LIBRETRO_CORE_LIB_FILE="${WORKDIR}/${P}_build/src/${LIBRETRO_CORE_NAME}_libretro/${LIBRETRO_CORE_NAME}_libretro.so"
	libretro-core_src_install
}
