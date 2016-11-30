# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of NXEngine. (Cave Story)"
HOMEPAGE="https://github.com/libretro/nxengine-libretro"
SRC_URI="https://github.com/libretro/nxengine-libretro/archive/ee6515869ca6b8271af2682bdf22cec9b18d40f8.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/nxengine-libretro-ee6515869ca6b8271af2682bdf22cec9b18d40f8"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/nxengine-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	filter-flags -O*
	emake $(usex debug "DEBUG=1" "") || die "emake failed"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "To play a game, like Cave Story, put the gamefiles"
		elog "to your rgui_browser_directory and select the executable as game"
		elog ""
		ewarn ""
	fi
}
