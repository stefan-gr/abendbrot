# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/reicast-emulator"
inherit libretro-core

DESCRIPTION="libretro implementation of Reicast. (Sega Dreamcast )"
HOMEPAGE="https://github.com/libretro/reicast-emulator"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="oit"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_unpack() {
	# We need to add the different core names to the array
	# in order to let the eclass handle the install
	LIBRETRO_CORE_NAME+=( "${PN%-libretro}" )
	libretro-core_src_unpack
}

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
