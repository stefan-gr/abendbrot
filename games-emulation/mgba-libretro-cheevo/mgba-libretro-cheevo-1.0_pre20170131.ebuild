# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro-cheevo}"
LIBRETRO_COMMIT_SHA="998dc43314e6572c8e651d0f46afbefcf7d6aa47"
inherit libretro-core

DESCRIPTION="libretro fork of mGBA with achievment support. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/mgba"
KEYWORDS="amd64 x86 arm"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="neon"

DEPEND="!games-emulation/mgba-libretro"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=${PN%-libretro-cheevo}

src_compile() {
	myemakeargs=(
		$(usex neon "HAVE_NEON=1" "")
	)
	libretro-core_src_compile
}
