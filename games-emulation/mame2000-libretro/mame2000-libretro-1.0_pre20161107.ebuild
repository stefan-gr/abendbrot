# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="MAME2000 (0.37b5) for libretro."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
SRC_URI="https://github.com/libretro/mame2000-libretro/archive/b4ca94b692583d31310c5333fb2a4168002e5f66.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/mame2000-libretro-b4ca94b692583d31310c5333fb2a4168002e5f66"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/mame2000-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="MAME-GPL"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}
