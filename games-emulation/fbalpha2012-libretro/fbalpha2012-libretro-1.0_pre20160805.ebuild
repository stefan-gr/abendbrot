# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Final Burn Alpha 2012. Port of Final Burn Alpha to Libretro (0.2.97.24)"
HOMEPAGE="https://github.com/libretro/fbalpha2012"
SRC_URI="https://github.com/libretro/fbalpha2012/archive/d52f92d595df3478334e28c82bd8f9dc0f06c5cb.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/fbalpha2012-d52f92d595df3478334e28c82bd8f9dc0f06c5cb/svn-current/trunk"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/fbalpha2012.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86 arm"
fi

LICENSE="FBA"
SLOT="0"
IUSE="+profile_accuracy profile_balanced profile_performance"

REQUIRED_USE="^^ ( profile_accuracy profile_balanced profile_performance )"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	myemakeargs=(
		$(usex profile_accuracy "profile=accuracy" "")
		$(usex profile_balanced "profile=balanced" "")
		$(usex profile_performance "profile=performance" "")
	)
	emake "${myemakeargs[@]}" -f makefile.libretro || die "emake failed"
}
