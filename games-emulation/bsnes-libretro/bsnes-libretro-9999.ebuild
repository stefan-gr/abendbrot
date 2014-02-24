# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="libretro implementation of bSNES/higan. (Super Nintendo Entertainment System)"
HOMEPAGE="http://gitorious.org/bsnes"
SRC_URI=""

EGIT_REPO_URI="git://gitorious.org/bsnes/bsnes.git"
EGIT_BRANCH="libretro"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="profile_accuracy +profile_balanced profile_performance"

REQUIRED_USE="|| ( profile_accuracy profile_balanced profile_performance )"

RDEPEND=""
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD 
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_compile() {
	if use profile_balanced; then
		emake profile=balanced \
			ui=target-libretro \
			|| die "emake failed"
	mv "$S"/out/bsnes_libretro.so "${WORKDIR}"/bsnes_balanced_libretro.so
	fi
	if use profile_performance; then
		emake clean
		emake profile=performance \
			ui=target-libretro \
			|| die "emake failed"
	mv "$S"/out/bsnes_libretro.so "${WORKDIR}"/bsnes_performance_libretro.so
	fi
	if use profile_accuracy; then
		emake clean
		emake profile=accuracy \
			ui=target-libretro \
			|| die "emake failed"
	mv "$S"/out/bsnes_libretro.so "${WORKDIR}"/bsnes_accuracy_libretro.so
	fi
}

src_install() {
	if use profile_balanced; then
		insinto /usr/$(get_libdir)/libretro
		doins "${WORKDIR}"/bsnes_balanced_libretro.so
		doins "${WORKDIR}"/infos/dist/info/bsnes_balanced_libretro.info
	fi
	if use profile_performance; then
		insinto /usr/$(get_libdir)/libretro
		doins "${WORKDIR}"/bsnes_performance_libretro.so
		doins "${WORKDIR}"/infos/dist/info/bsnes_performance_libretro.info
	fi
	if use profile_accuracy; then
		insinto /usr/$(get_libdir)/libretro
		doins "${WORKDIR}"/bsnes_accuracy_libretro.so
		doins "${WORKDIR}"/infos/dist/info/bsnes_accuracy_libretro.info
	fi
}
