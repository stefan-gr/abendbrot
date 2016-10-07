# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Snes9x 2002. Port of SNES9x 1.39 for libretro (previously PocketSNES)"
HOMEPAGE="https://github.com/libretro/snes9x2002"
SRC_URI="https://github.com/libretro/snes9x2002/archive/fd7b58a53c5bae84075642f75c74e51ed5d9a22e.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/snes9x2002-fd7b58a53c5bae84075642f75c74e51ed5d9a22e"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://github.com/libretro/snes9x2002.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="PS"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}
