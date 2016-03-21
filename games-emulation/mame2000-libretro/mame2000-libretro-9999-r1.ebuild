# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="2000 version of MAME (0.37b5) for libretro. Compatible with iMAME4All/MAME4Droid/MAME 0.37b5 romsets."
HOMEPAGE="https://github.com/libretro/mame2000-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/mame2000-libretro.git"

LICENSE="MAME-GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	use amd64 && emake
	use x86 && emake
	use arm && emake ARM=1
	use arm64 && emake ARM=1
}

