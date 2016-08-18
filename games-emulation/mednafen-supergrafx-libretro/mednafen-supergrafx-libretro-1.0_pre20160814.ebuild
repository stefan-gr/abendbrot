# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen PCE Fast. (SuperGrafx TG-16)"
HOMEPAGE="https://github.com/libretro/beetle-supergrafx-libretro"
SRC_URI="https://github.com/libretro/beetle-supergrafx-libretro/archive/ec439714fcd4d3a332c948288fe9d52f43d427ed.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/beetle-supergrafx-libretro-ec439714fcd4d3a332c948288fe9d52f43d427ed"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/beetle-supergrafx-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_supergrafx
