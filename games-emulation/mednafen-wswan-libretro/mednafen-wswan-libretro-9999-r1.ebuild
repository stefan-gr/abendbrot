# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Cygne. (WonderSwan/WonderSwan Color)"
HOMEPAGE="https://github.com/libretro/beetle-wswan-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-wswan-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=mednafen_wswan

src_compile() {
	emake core=wswan || die "emake failed"
}
