# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="6d78e8f0578d20a81d7fc78afaa25c5d8582caa3"
LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="Final Burn Alpha 2012. Port of Final Burn Alpha to Libretro (0.2.97.24)"
HOMEPAGE="https://github.com/libretro/fbalpha2012"
KEYWORDS="amd64 x86 arm"

S="${S}/svn-current/trunk"

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
