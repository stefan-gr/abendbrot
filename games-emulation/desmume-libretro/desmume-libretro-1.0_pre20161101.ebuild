# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of DeSmuME. (Nintendo DS)"
HOMEPAGE="https://github.com/libretro/desmume"
SRC_URI="https://github.com/libretro/desmume/archive/ab1bd5a1de0ca329ff26b894b818f553ff8ebba6.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/desmume-ab1bd5a1de0ca329ff26b894b818f553ff8ebba6"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/desmume.git"
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

S="${S}/desmume"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f Makefile.libretro || die "emake failed"
}
