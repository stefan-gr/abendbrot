# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of FCEUmm/FCEUX. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/fceu-next"
SRC_URI="https://github.com/libretro/fceu-next/archive/ebd46a592c23a8091abd72e74cf0d9f4517769e1.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/fceu-next-ebd46a592c23a8091abd72e74cf0d9f4517769e1"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/fceu-next.git"
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

S="${S}/fceumm-code"
LIBRETRO_CORE_NAME=fceumm

src_compile() {
	emake $(usex debug "DEBUG=1" "") -f Makefile.libretro
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to have the following files in your 'system_directory' folder:"
		ewarn "disksys.rom (Famicom Disk System BIOS)"
		ewarn ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
