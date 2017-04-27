# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN/mednafen/beetle}"
LIBRETRO_COMMIT_SHA="af9ff403174f297a18027f3f77910fad2c26d135"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Neopop. Neo Geo Pocket/Neo Geo Pocket Color"
HOMEPAGE="https://github.com/libretro/beetle-ngp-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_ngp
