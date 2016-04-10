# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of VBA Next. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/vba-next"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/vba-next.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE="neon +tiled_rendering"

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=vba_next

src_compile() {
	myemakeargs=(
		$(usex arm "platform=armv" "")
		$(usex neon "HAVE_NEON=1" "")
		$(usex tiled_rendering "TILED_RENDERING=1" "")
	)
	emake "${myemakeargs[@]}" -f Makefile.libretro || die "emake failed"
}
