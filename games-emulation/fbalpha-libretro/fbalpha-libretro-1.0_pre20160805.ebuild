# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Port of Final Burn Alpha to Libretro"
HOMEPAGE="https://github.com/libretro/fbalpha"
SRC_URI="https://github.com/libretro/fbalpha/archive/25ed7a6dbb3185822bfd0ccd41bf929a4dfb2b06.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/fbalpha-25ed7a6dbb3185822bfd0ccd41bf929a4dfb2b06"

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
	myemakeargs=(
		$(usex debug "DEBUG=1" "")
	)
	emake "${myemakeargs[@]}" -f makefile.libretro || die "emake failed"
}
