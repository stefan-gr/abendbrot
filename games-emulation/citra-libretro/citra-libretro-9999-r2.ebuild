# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
# These are used by citra and externals/dynarmic which seems to break with git-r3.eclass
EGIT_SUBMODULES=("*" "-externals/dynarmic/externals/fmt" "-externals/dynarmic/externals/xbyak")
inherit libretro-core

DESCRIPTION="libretro implementation of Citra. (Nintendo 3DS)"
HOMEPAGE="https://github.com/libretro/citra"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="+system-ffmpeg"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info
	system-ffmpeg? ( media-video/ffmpeg:0= )"

RDEPEND="virtual/opengl"
DEPEND="${DEPEND}"


src_compile() {
	myemakeargs=(
		$(usex system-ffmpeg "HAVE_FFMPEG_STATIC=0" "HAVE_FFMPEG_STATIC=1")
	)
	libretro-core_src_compile
}
