# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of PicoDrive. \
(Sega GameGear/Sega CD/32X)"
HOMEPAGE="https://github.com/libretro/picodrive"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/picodrive.git"

LICENSE="PD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure() {
	#No need for configure, libretro does its own thing
	true
}

src_compile() {
	make -f Makefile.libretro || die "emake failed!"
}

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/picodrive_libretro
	doins "${S}"/COPYING
	libretro-core_src_install
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
		ewarn "bios_CD_E.bin (MegaCD EU BIOS)"
		ewarn "bios_CD_U.bin (SegaCD US BIOS)"
		ewarn "bios_CD_J.bin (MegaCD JP BIOS)"
		ewarn ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
