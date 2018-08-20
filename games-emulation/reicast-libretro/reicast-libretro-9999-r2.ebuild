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
	use oit && LIBRETRO_CORE_NAME+=( "${PN%-libretro}"_oit )
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
	libretro-core_src_compile
	if use oit; then
		# Prevent the deletion of compiled core
		mv reicast_libretro.so reicast_libretro
		emake clean
		mv reicast_libretro reicast_libretro.so
		myemakeargs+=( "HAVE_OIT=1" )
		libretro-core_src_compile
	fi
}
