# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="fbbe839d1cdf40a8412cfaee29ee51fe9fd455a2"
inherit libretro-core

DESCRIPTION="libretro implementation of ScummVM"
HOMEPAGE="https://github.com/libretro/scummvm"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/backends/platform/libretro/build"
