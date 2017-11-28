# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-${PN//-libretro}"
LIBRETRO_COMMIT_SHA="2012133dbfcbcb62ce3ce5fa2b652011720f9446"
inherit libretro-core

DESCRIPTION="libretro implementation of 2048. (Puzzle game)"
HOMEPAGE="https://github.com/libretro/libretro-2048"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
