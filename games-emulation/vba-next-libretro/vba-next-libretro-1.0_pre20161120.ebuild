# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="0b1b2060290ba96a7af39680e2b04b4c53bd80c3"
LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of VBA Next. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/vba-next"
KEYWORDS="amd64 x86 arm"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug neon +tiled_rendering"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=vba_next

src_compile() {
	myemakeargs=(
		$(usex arm "platform=armv" "")
		$(usex neon "HAVE_NEON=1" "")
		$(usex debug "DEBUG=1" "")
		$(usex tiled_rendering "TILED_RENDERING=1" "")
	)
	filter-flags -O*
	emake "${myemakeargs[@]}" -f Makefile.libretro || die "emake failed"
}
