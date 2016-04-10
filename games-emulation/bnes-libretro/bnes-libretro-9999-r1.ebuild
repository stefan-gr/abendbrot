# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core toolchain-funcs

DESCRIPTION="libretro implementation of bNES/higan. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/bnes-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_pretend() {
	#doesn't compile with >gcc5, see bug https://github.com/libretro/bnes-libretro/issues/7
	if [[ ${MERGE_TYPE} != binary  && $(tc-getCC) == *gcc* ]]; then
		if [[ $(gcc-major-version) -gt 4 ]] ; then
			die 'The active compiler needs to be gcc 4.9 (or older)'
		fi
	fi
}
