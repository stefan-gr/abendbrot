# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Craft. (Minecraft clone)"
HOMEPAGE="https://github.com/libretro/Craft"
SRC_URI=""

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/Craft.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="Craft"
SLOT="0"
IUSE="debug gles2"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "DEBUG=0") $(usex gles2 "GLES=1" "GLES=0") || die "emake failed"
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/${PN}
	doins "${S}"/LICENSE.md
	libretro-core_src_install
}
