# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_COMMIT_SHA="bb55b3b7a96b1a51a46931e0246294cef41cedfc"
LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit flag-o-matic check-reqs libretro-core

DESCRIPTION="libretro implementation of MAME 2015. (Arcade)"
HOMEPAGE="https://github.com/libretro/mame"
KEYWORDS="amd64 x86"

LICENSE="GPL-2+"
SLOT="0"
IUSE="debug"

DEPEND=">=sys-devel/gcc-5.0"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

CHECKREQS_MEMORY="9G" # Debug build requires more see bug #47
CHECKREQS_DISK_BUILD="25G" # Debug build requires more see bug #47

pkg_pretend() {
	if is-flagq "-ggdb"; then
		einfo "Checking for sufficient disk space to build ${PN} with debugging CFLAGS"
		check-reqs_pkg_pretend
	fi
}

pkg_setup() {
	if is-flagq "-ggdb"; then
		check-reqs_pkg_setup
	fi
}

src_prepare(){
	default_src_prepare
	if [[ $(tc-getCXX) == *g++* && $(gcc-version) < 5.1 ]]; then
		# Check for mame version and apply gcc < 5.1 patch
		# See https://bugs.gentoo.org/show_bug.cgi?id=582576
		if [[ $(grep ' #define BARE_BUILD_VERSION' makefile | grep -o -E '[0-9][0-9][0-9]') < 175 ]]; then
			epatch "${FILESDIR}"/sdlmame-0.174-cxx14.patch || die "epatch failed!"
		fi
	fi
}

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f Makefile.libretro || die "emake failed"
}
