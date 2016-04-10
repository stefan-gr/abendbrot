# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of 2048. (Puzzle game)"
HOMEPAGE="https://github.com/libretro/libretro-2048"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-2048.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	emake -f Makefile.libretro || die "emake failed"
}
