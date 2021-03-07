# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/bsnes"
inherit libretro-core

DESCRIPTION="Port of bsnes to Libretro"
HOMEPAGE="https://github.com/libretro/bsnes"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="neon"

DEPEND=""
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

S="${S}/bsnes"

LIBRETRO_CORE_NAME=bsnes

src_compile() {
	myemakeargs=(
		"target=libretro"
		"binary=library"
		"local=false"
		"platform=linux"
	)
	libretro-core_src_compile
	mv out/bsnes_libretro.so .
}
