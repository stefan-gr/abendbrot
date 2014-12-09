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
		insinto /usr/share/libretro/info/
		doins "${WORKDIR}"/infos/dist/info/bsnes_balanced_libretro.info
	fi
	if use profile_performance; then
		insinto /usr/$(get_libdir)/libretro
		doins "${WORKDIR}"/bsnes_performance_libretro.so
		insinto /usr/share/libretro/info/
		doins "${WORKDIR}"/infos/dist/info/bsnes_performance_libretro.info
	fi
	if use profile_accuracy; then
		insinto /usr/$(get_libdir)/libretro
		doins "${WORKDIR}"/bsnes_accuracy_libretro.so
		insinto /usr/share/libretro/info/
		doins "${WORKDIR}"/infos/dist/info/bsnes_accuracy_libretro.info
	fi
}

pkg_postinst() {
	elog ""
	elog "You should put some bios files in your 'system_directory'"
	elog "otherwise a few games will not work. Please place them in the following directory:"
	elog "~/.local/share/retroarch/system/"
	elog ""
	elog "Here is a list with recommended optional files:"
	elog "dsp1.data.rom (DSP1 DATA)"
	elog "dsp1.program.rom (DSP1 PROGRAM)"
	elog "dsp1b.data.rom (DSP1B DATA)"
	elog "dsp1b.program.rom (DSP1B PROGRAM)"
	elog "dsp2.data.rom (DSP2 DATA)"
	elog "dsp2.program.rom (DSP2 PROGRAM)"
	elog "dsp3.data.rom (DSP3 DATA)"
	elog "dsp3.program.rom (DSP3 PROGRAM)"
	elog "dsp4.data.rom (DSP4 DATA)"
	elog "dsp4.program.rom (DSP4 PROGRAM)"
	elog "cx4.data.rom (Cx4 DATA)"
	elog "st010.data.rom (ST-0010 DATA)"
	elog "st010.program.rom (ST-0010 PROGRAM)"
	elog "st011.program.rom (ST-0011 PROGRAM)"
	elog "st018.program.rom (ST-0018 PROGRAM)"
	elog "sgb.boot.rom (SGB BOOT)"
	elog ""
	elog "Some games affected:"
	elog "DSP1/DSP1B games: Super Mario Kart / Pilotwings"
	elog "DSP2 games: Dungeon Master"
	elog "DSP3 games: SD Gundam GX"
	elog "DSP4 games: Top Gear 3000"
	elog "Cx4 games: Mega Man X2 / Mega Man X3"
	elog ""
}
