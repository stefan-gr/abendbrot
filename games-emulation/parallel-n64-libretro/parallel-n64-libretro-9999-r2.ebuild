# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/parallel-n64"
LIBRETRO_CORE_NAME="parallel_n64"
inherit libretro-core

DESCRIPTION="Rewritten Nintendo 64 emulator made specifically for Libretro."
HOMEPAGE="https://github.com/libretro/parallel-n64"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="gles2 vulkan"

DEPEND="media-libs/mesa:0=
		gles2? ( media-libs/mesa[gles2] )
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
		$(usex gles2 "FORCE_GLES=1" "FORCE_GLES=0")
		$(usex vulkan "HAVE_PARALLEL=1 HAVE_PARALLEL_RSP=1" "HAVE_PARALLEL=0 HAVE_PARALLEL_RSP=0")
		"HAVE_THR_AL=1"
	)
	libretro-core_src_compile
}
