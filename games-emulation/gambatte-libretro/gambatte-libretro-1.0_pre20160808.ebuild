# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Gambatte. (Game Boy/Game Boy Color)"
HOMEPAGE="https://github.com/libretro/gambatte-libretro"
SRC_URI="https://github.com/libretro/gambatte-libretro/archive/36391e168b2f739dd06a03f979ee22f0b195e2ca.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/gambatte-libretro-36391e168b2f739dd06a03f979ee22f0b195e2ca"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/gambatte-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/libgambatte"

src_compile() {
	emake -f Makefile.libretro || die "emake failed"
}
