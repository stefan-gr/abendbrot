# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen VB. (Virtual Boy)"
HOMEPAGE="https://github.com/libretro/beetle-vb-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-vb-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=mednafen_vb

src_compile() {
	emake core=vb || die "emake failed"
}
