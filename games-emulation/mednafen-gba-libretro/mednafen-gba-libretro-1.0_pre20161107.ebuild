# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen VBA/GBA. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/beetle-gba-libretro"
SRC_URI="https://github.com/libretro/beetle-gba-libretro/archive/b17b3a2e5e1d30220f75f823b04f609d94eb1ce0.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/beetle-gba-libretro-b17b3a2e5e1d30220f75f823b04f609d94eb1ce0"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/beetle-gba-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_gba

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") core=gba || die "emake failed"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
		elog "gba_bios.bin (GBA BIOS)"
		elog ""
		ewarn ""
	fi
}