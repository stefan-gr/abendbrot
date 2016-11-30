# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Neopop. Neo Geo Pocket/Neo Geo Pocket Color"
HOMEPAGE="https://github.com/libretro/beetle-ngp-libretro"
SRC_URI="https://github.com/libretro/beetle-ngp-libretro/archive/15887b8a2b2f120433734ad3ca57e748a6571ee4.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/beetle-ngp-libretro-15887b8a2b2f120433734ad3ca57e748a6571ee4"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/beetle-ngp-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

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
