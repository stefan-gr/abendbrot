# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="646fad96a5b441ff27ba43d21075236d470615ca"
LIBRETRO_REPO_NAME="libretro/QuickNES_Core"
inherit libretro-core

DESCRIPTION="libretro implementation of QuickNES. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/QuickNES_Core"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
