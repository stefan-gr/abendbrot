# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
LIBRETRO_COMMIT_SHA="dc448f8f5ef85e83cfecb080b57cfe4950eec31a"
inherit libretro-core

DESCRIPTION="libretro implementation of SNES9x. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/snes9x"
KEYWORDS="~amd64 ~x86"

LICENSE="snes9x"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

MY_S="${S}"
S="${S}/libretro"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/snes9x_libretro
	doins "${MY_S}"/docs/snes9x-license.txt
	libretro-core_src_install
}
