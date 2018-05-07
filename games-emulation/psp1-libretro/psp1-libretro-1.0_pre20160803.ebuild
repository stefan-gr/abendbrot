# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="edf1cb70cc01c9f4ce81a83e1538c7b5ab7a2658"
LIBRETRO_REPO_NAME="libretro-mirrors/PSP1"
inherit libretro-core

DESCRIPTION="Non-shallow fork of PPSSPP for libretro exclusively."
HOMEPAGE="https://github.com/libretro-mirrors/PSP1"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="gles2"

DEPEND="x11-libs/libICE
	sys-libs/zlib
	x11-libs/libXt
	x11-libs/libXext
	media-libs/mesa
	gles2? ( media-libs/mesa[gles2] )
	gles2? ( dev-libs/wayland )
	games-emulation/psp-assets"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S=${S}/libretro

src_prepare() {
	libretro-core_src_prepare
	#fixing ARCH detection
	sed -i Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die '"sed" failed'
	sed -i Makefile.common \
		-e 's:ifeq ($(WITH_DYNAREC), arm):ifneq (,$(findstring arm,$(WITH_DYNAREC))):' \
		|| die '"sed" failed'
}

src_compile() {
	use gles2 && append-ldflags -lEGL
	myemakeargs=(
		$(usex gles2 "GLES=1" "")
	)
	libretro-core_src_compile
}
