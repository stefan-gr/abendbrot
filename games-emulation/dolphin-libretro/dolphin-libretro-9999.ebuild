# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="libretro implementation of Dolphin. (Nintendo GC/Wii)"
HOMEPAGE="https://github.com/libretro/dolphin"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/dolphin.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	#fixing ARCH detection
	sed -i libretro/Makefile \
		-e 's:$(ARCH):$(REAL_ARCH):' \
		|| die
	sed -i libretro/Makefile \
		-e 's:ARCH = $(shell uname -m):REAL_ARCH = $(shell uname -m):' \
		|| die
}

src_compile() {
	cd ${S}/libretro
	emake
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	doins "${S}"/libretro/dolphin_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/dolphin_libretro.info
}
