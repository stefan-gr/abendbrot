# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of PocketSNES."
HOMEPAGE="https://github.com/libretro/pocketsnes-libretro"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/pocketsnes-libretro.git"
if [[ ${PV} == 9999 ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT_DATE="${PV:7:4}-${PV:11:2}-${PV:13:2}"
	KEYWORDS="amd64 x86"
fi

LICENSE="PS"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"
