# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of Meteor. (Game Boy Advance)"
HOMEPAGE="https://github.com/libretro/meteor-libretro"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

S="${S}/libretro"

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD 
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/meteor_libretro.so
	doins "${WORKDIR}"/infos/dist/info/meteor_libretro.info
}
