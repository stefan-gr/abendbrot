# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro fork of mGBA with achievment support. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/mgba"
SRC_URI="https://github.com/libretro/mgba/archive/56bb37e98f4b505cc7772f185948389f2c8ee698.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/mgba-56bb37e98f4b505cc7772f185948389f2c8ee698"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/mgba.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86 arm"
fi

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
