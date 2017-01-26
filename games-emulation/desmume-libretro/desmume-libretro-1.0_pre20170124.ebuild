# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="62786c58933b680e4ce211e92e4ea33f2caa2418"
inherit libretro-core

DESCRIPTION="libretro implementation of DeSmuME. (Nintendo DS)"
HOMEPAGE="https://github.com/libretro/desmume"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/desmume"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f Makefile.libretro || die "emake failed"
}
