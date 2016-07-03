# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of PocketSNES."
HOMEPAGE="https://github.com/libretro/pocketsnes-libretro"
SRC_URI="https://github.com/libretro/pocketsnes-libretro/archive/c87b24f54d0e6ac3478902ebd71bbacd122d3712.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/pocketsnes-libretro-c87b24f54d0e6ac3478902ebd71bbacd122d3712"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/libretro/pocketsnes-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="PS"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"
