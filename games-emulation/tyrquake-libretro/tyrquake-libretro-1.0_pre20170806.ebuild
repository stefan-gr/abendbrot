# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="010564ab552f6e9ffb8ea1e0ff0f200989121689"
inherit libretro-core

DESCRIPTION="libretro implementation of TyrQuake. (Quake)"
HOMEPAGE="https://github.com/libretro/tyrquake"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
