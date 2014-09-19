# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of Genesis Plus GX. \
(Sega Genesis/Sega CD)"
HOMEPAGE="https://github.com/libretro/Genesis-Plus-GX"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/Genesis-Plus-GX.git"

LICENSE="GPGX"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	emake -f Makefile.libretro || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/genesis_plus_gx_libretro.so
	doins "${WORKDIR}"/infos/dist/info/genesis_plus_gx_libretro.info
	insinto /usr/share/libretro/genesis_plus_gx_libretro
	doins "${S}"/LICENSE.txt
}
