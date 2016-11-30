# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Gambatte. (Game Boy/Game Boy Color)"
HOMEPAGE="https://github.com/libretro/gambatte-libretro"
SRC_URI="https://github.com/libretro/gambatte-libretro/archive/4d8ae4f5c259f3a274edf22014eb91dba7bc6cdf.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/gambatte-libretro-4d8ae4f5c259f3a274edf22014eb91dba7bc6cdf"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/gambatte-libretro.git"
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

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f Makefile.libretro || die "emake failed"
}
