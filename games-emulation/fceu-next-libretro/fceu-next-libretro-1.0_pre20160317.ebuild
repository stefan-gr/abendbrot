# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="ebd46a592c23a8091abd72e74cf0d9f4517769e1"
LIBRETRO_REPO_NAME="libretro/${PN//-libretro}"
inherit libretro-core

DESCRIPTION="libretro implementation of FCEUmm/FCEUX. (Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/fceu-next"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND="!games-emulation/fceumm-libretro"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

S="${S}/fceumm-code"
LIBRETRO_CORE_NAME=fceumm

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
		ewarn ""
	fi
}
