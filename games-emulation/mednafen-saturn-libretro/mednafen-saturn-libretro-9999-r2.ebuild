# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN/mednafen-saturn/beetle-saturn}"
inherit libretro-core

DESCRIPTION="Standalone port of Mednafen Saturn to the libretro"
HOMEPAGE="https://github.com/libretro/beetle-saturn-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="debug opengl"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

pkg_setup() {
	! use opengl && LIBRETRO_CORE_NAME="mednafen_saturn"
	use opengl && LIBRETRO_CORE_NAME="mednafen_saturn_hw"
}

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "DEBUG=0") $(usex opengl "HAVE_OPENGL=1" "HAVE_OPENGL=0") || die "emake failed"
}
