# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Snes9x 2002. Port of SNES9x 1.39 for libretro (previously PocketSNES)"
HOMEPAGE="https://github.com/libretro/snes9x2002"
SRC_URI="https://github.com/libretro/snes9x2002/archive/c87b24f54d0e6ac3478902ebd71bbacd122d3712.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/snes9x2002-c87b24f54d0e6ac3478902ebd71bbacd122d3712"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/libretro/snes9x2002.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="PS"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME="pocketsnes"
