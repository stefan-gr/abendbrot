# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN/mednafen/beetle}"
LIBRETRO_COMMIT_SHA="626182666afd09d887a294332fa04693cc894703"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Neopop. Neo Geo Pocket/Neo Geo Pocket Color"
HOMEPAGE="https://github.com/libretro/beetle-ngp-libretro"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_ngp

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") core=ngp || die "emake failed"
}
