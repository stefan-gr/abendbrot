# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core flag-o-matic

DESCRIPTION="libretro implementation of PPSSPP. (PlayStation Portable/PSP)"
HOMEPAGE="https://github.com/libretro/libretro-ppsspp"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-ppsspp.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="gles2"

RDEPEND="x11-libs/libICE
	sys-libs/zlib
	x11-libs/libXt
	x11-libs/libXext
	media-libs/mesa
	gles2? ( media-libs/mesa[gles2] )
	gles2? ( dev-libs/wayland )
	games-emulation/psp-assets"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/libretro

src_prepare() {
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
	if use gles2; then
		append-ldflags -lEGL
		emake GLES=1
	else
		emake
	fi
}
