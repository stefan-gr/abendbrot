# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of Citra. (Nintendo 3DS)"
HOMEPAGE="https://github.com/libretro/citra"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info
	media-video/ffmpeg"

RDEPEND="virtual/opengl"
DEPEND="${DEPEND}"


src_compile() {
	# 2022-02-25: doesn't build successfully with static ffmpeg, don't bother and enforce dynamic linking 
	myemakeargs=(
		"HAVE_FFMPEG_STATIC=0"
	)
	libretro-core_src_compile
}
