# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of bNES/higan. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/bnes-libretro"
SRC_URI="https://github.com/libretro/bnes-libretro/archive/44b1f2d17821693e15a935fde1e249daddcce1b7.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/bnes-libretro-44b1f2d17821693e15a935fde1e249daddcce1b7"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/bnes-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	default_src_compile
}
