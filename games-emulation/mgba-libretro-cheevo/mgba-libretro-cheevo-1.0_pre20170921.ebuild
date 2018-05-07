# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro-cheevo}"
LIBRETRO_COMMIT_SHA="337fc06385f08ef610f3425cb6c16bac14064192"
inherit libretro-core

DESCRIPTION="libretro fork of mGBA with achievment support. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/mgba"
KEYWORDS="amd64 x86"

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
