# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="Snes9x 2010. Port of Snes9x 1.52+ to Libretro (previously called SNES9x Next)"
HOMEPAGE="https://github.com/libretro/snes9x2010"
SRC_URI="https://github.com/libretro/snes9x2010/archive/5efcfb79137ddb885f093ac4547dafb9a8673c2e.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/snes9x2010-5efcfb79137ddb885f093ac4547dafb9a8673c2e"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/snes9x2010.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="snes9x"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") -f Makefile.libretro
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/snes9x2010_libretro
	doins "${S}"/docs/snes9x-license.txt
	libretro-core_src_install
}
