# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen Cygne. (WonderSwan/WonderSwan Color)"
HOMEPAGE="https://github.com/libretro/beetle-wswan-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-wswan-libretro.git"
if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT_DATE="${PV:7:4}-${PV:11:2}-${PV:13:2}"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=mednafen_wswan

src_compile() {
	emake core=wswan || die "emake failed"
}
