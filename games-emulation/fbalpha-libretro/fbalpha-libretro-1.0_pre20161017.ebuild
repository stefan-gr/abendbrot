# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Port of Final Burn Alpha to Libretro"
HOMEPAGE="https://github.com/libretro/fbalpha"
SRC_URI="https://github.com/libretro/fbalpha/archive/6324165fe7722d1143d6a28395d81abf581ce8ea.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/fbalpha-6324165fe7722d1143d6a28395d81abf581ce8ea"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/fbalpha.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86 arm"
fi

LICENSE="FBA"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	# Doesn't work properly with -O3 and sets its own depending on need.
	# https://github.com/stefan-gr/abendbrot/issues/42
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f makefile.libretro || die "emake failed"
}
