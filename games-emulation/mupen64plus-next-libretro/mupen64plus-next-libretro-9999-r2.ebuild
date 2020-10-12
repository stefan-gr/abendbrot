# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/mupen64plus-libretro-nx"
inherit libretro-core

DESCRIPTION="libretro implementation of mupen64plus (Nintendo64)"
HOMEPAGE="https://github.com/libretro/mupen64plus-libretro-nx"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="gles3 vulkan"

DEPEND="media-libs/mesa:0=
		gles3? ( media-libs/mesa[gles2] )
		media-libs/libpng:0=
		dev-lang/nasm:0="
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	myemakeargs=(
		$(usex amd64 "WITH_DYNAREC=x86_64" "")
		$(usex x86 "WITH_DYNAREC=x86" "")
		$(usex arm "WITH_DYNAREC=arm" "")
		$(usex arm64 "WITH_DYNAREC=aarch64" "")
		$(usex gles3 "GLES3=1" "GLES3=0")
		$(usex vulkan "HAVE_PARALLEL_RDP=1" "HAVE_PARALLEL_RDP=0")
		"HAVE_THR_AL=1"
		"LLE=1"
	)
	libretro-core_src_compile
}
