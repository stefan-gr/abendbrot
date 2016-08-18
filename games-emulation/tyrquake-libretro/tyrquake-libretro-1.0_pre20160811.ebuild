# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of TyrQuake. (Quake)"
HOMEPAGE="https://github.com/libretro/tyrquake"
SRC_URI="https://github.com/libretro/tyrquake/archive/ff67c16778f29a3002ae64596635205de4a08f65.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/tyrquake-ff67c16778f29a3002ae64596635205de4a08f65"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/tyrquake.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
