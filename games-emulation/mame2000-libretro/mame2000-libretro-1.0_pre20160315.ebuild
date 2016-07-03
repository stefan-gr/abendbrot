# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="MAME2000 (0.37b5) for libretro."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
SRC_URI="https://github.com/libretro/mame2000-libretro/archive/7eaacdd2b4bbec11f01e047cbfedf150acd01d08.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/mame2000-libretro-7eaacdd2b4bbec11f01e047cbfedf150acd01d08"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/mame2000-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="MAME-GPL"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"
