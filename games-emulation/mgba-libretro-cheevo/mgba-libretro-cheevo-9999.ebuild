# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro fork of mGBA with achievment support. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/mgba"
SRC_URI=""
EGIT_REPO_URI="https://github.com/libretro/mgba.git"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

RDEPEND="!games-emulation/mgba-libretro"
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=${PN%-libretro-cheevo}
# Absolute path of the directory containing libretro data files.
LIBRETRO_DATA_DIR=${GAMES_DATADIR}/libretro
