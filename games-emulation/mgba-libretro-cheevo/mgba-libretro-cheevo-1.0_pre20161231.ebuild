# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro-cheevo}"
LIBRETRO_COMMIT_SHA="90629bc247870854a6dea00582866906296ffa2e"
inherit libretro-core

DESCRIPTION="libretro fork of mGBA with achievment support. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/mgba"
KEYWORDS="~amd64 ~x86 ~arm"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="debug neon"

DEPEND="!games-emulation/mgba-libretro"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=${PN%-libretro-cheevo}

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") $(usex neon "HAVE_NEON=1" "") || die "emake failed"
}
