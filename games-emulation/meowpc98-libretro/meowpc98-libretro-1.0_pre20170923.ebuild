# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/libretro-meowPC98"
LIBRETRO_COMMIT_SHA="990d556216922a733295962273da2baa370f2b92"
inherit libretro-core

DESCRIPTION="Neko Project 2 (PC98 emulator) port for libretro/RetroArch (XNP2)"
HOMEPAGE="https://github.com/libretro/libretro-meowPC98"
KEYWORDS="amd64 x86"

LICENSE="BSD"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libretro"

LIBRETRO_CORE_NAME=nekop2
