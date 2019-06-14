# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/flycast"
inherit libretro-core

DESCRIPTION="libretro fork of Reicast. (Sega Dreamcast/Naomi/Atomiswave)"
HOMEPAGE="https://github.com/libretro/flycast"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="oit"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=flycast

src_prepare() {
	libretro-core_src_prepare
	#fixing ARCH detection
	sed -i Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die '"sed" failed'
}

src_compile() {
	if use oit; then
		myemakeargs+=( "HAVE_OIT=1" )
	fi
	libretro-core_src_compile
}
