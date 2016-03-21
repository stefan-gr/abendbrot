# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen PSX. (PlayStation, beetle version)"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/beetle-psx-libretro.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

LIBRETRO_CORE_NAME=beetle_psx

src_compile() {
	emake core=psx || die "emake failed"
}

src_install() {
	mv "${S}"/mednafen_psx_libretro.so "${S}"/beetle_psx_libretro.so
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
		ewarn "scph5500.bin md5sum = 8dd7d5296a650fac7319bce665a6a53c"
		ewarn "scph5501.bin md5sum = 490f666e1afb15b7362b406ed1cea246"
		ewarn "scph5502.bin md5sum = 32736f17079d0b2b7024407c39bd3050"
		ewarn ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
