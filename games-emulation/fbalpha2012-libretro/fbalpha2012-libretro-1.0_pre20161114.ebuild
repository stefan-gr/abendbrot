# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Final Burn Alpha 2012. Port of Final Burn Alpha to Libretro (0.2.97.24)"
HOMEPAGE="https://github.com/libretro/fbalpha2012"
SRC_URI="https://github.com/libretro/fbalpha2012/archive/40188aa71fd0512d2e452a6ef6db9cca56d67730.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/fbalpha2012-40188aa71fd0512d2e452a6ef6db9cca56d67730"

S="${S}/svn-current/trunk"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/fbalpha2012.git"
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
