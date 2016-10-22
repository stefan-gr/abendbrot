# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Reicast. (Sega Dreamcast )"
HOMEPAGE="https://github.com/libretro/reicast-emulator"
SRC_URI="https://github.com/libretro/reicast-emulator/archive/da0d8ff353377cbbb00ff3e5433864951210b3f5.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/reicast-emulator-da0d8ff353377cbbb00ff3e5433864951210b3f5"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/reicast-emulator.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug gles2 naomi"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_unpack() {
	# We need to add the different core names to the array
	# in order to let the eclass handle the install
	LIBRETRO_CORE_NAME+=( "${PN%-libretro}" )
	use naomi && LIBRETRO_CORE_NAME+=( "${PN%-libretro}"_naomi )
	libretro-core_src_unpack
}

src_prepare() {
	default_src_prepare
	#fixing ARCH detection
	sed -i Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die '"sed" failed'
}

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "DEBUG=0") $(usex gles2 "GLES=1" "GLES=0") || die "emake failed"
	if use naomi; then
		# Prevent the deletion of compiled core
		mv reicast_libretro.so reicast_libretro
		emake clean
		mv reicast_libretro reicast_libretro.so
		emake $(usex debug "DEBUG=1" "DEBUG=0") $(usex gles2 "GLES=1" "GLES=0") NAOMI=1 || die "emake failed"
	fi
}
