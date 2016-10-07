# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 libretro-core flag-o-matic

DESCRIPTION="Non-shallow fork of PPSSPP for libretro exclusively."
HOMEPAGE="https://github.com/libretro/PSP1"
SRC_URI=""
EGIT_REPO_URI="git://github.com/libretro/PSP1.git"

if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT_DATE="${PV:7:4}-${PV:11:2}-${PV:13:2}"
	KEYWORDS="amd64 x86 arm"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug gles2"

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
	#fixing ARCH detection
	sed -i Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die '"sed" failed'
	sed -i Makefile.common \
		-e 's:ifeq ($(WITH_DYNAREC), arm):ifneq (,$(findstring arm,$(WITH_DYNAREC))):' \
		|| die '"sed" failed'
	default_src_prepare
}

src_compile() {
	if use gles2; then
		append-ldflags -lEGL
	fi

	emake $(usex debug "DEBUG=1" "") $(usex gles2 "GLES=1" "")
}
