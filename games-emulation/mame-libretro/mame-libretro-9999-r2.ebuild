# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit flag-o-matic check-reqs versionator libretro-core

DESCRIPTION="libretro implementation of MAME 2015. (Arcade)"
HOMEPAGE="https://github.com/libretro/mame"
KEYWORDS=""

LICENSE="GPL-2+"
SLOT="0"

DEPEND=">=sys-devel/gcc-5.1"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

CHECKREQS_MEMORY="9G" # Debug build requires more see bug #47
CHECKREQS_DISK_BUILD="25G" # Debug build requires more see bug #47

pkg_pretend() {
	if ! version_is_at_least 5.1 $(gcc-version); then
		die "You need at least GCC 5.1.x to build mame succesfully."
	fi

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
