# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit libretro-core

DESCRIPTION="libretro implementation of bSNES/higan. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/bsnes-libretro"
SRC_URI=""

EGIT_REPO_URI="git://github.com/libretro/bsnes-libretro.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="profile_accuracy +profile_balanced profile_performance"

REQUIRED_USE="|| ( profile_accuracy profile_balanced profile_performance )"

RDEPEND=""
DEPEND="${RDEPEND}"

INFO_PATH="${WORKDIR}"/infos/dist/info
LIBRETRO_CORE_INFO_FILE="${INFO_PATH}/${LIBRETRO_CORE_NAME}"_balanced_libretro.info

src_compile() {
	if use profile_balanced; then
		emake profile=balanced \
			ui=target-libretro \
			|| die "emake failed"
	fi
	if use profile_performance; then
		emake clean
		emake profile=performance \
			ui=target-libretro \
			|| die "emake failed"
	fi
	if use profile_accuracy; then
		emake clean
		emake profile=accuracy \
			ui=target-libretro \
			|| die "emake failed"
	fi
}

src_install() {
	if use profile_balanced; then
		insinto ${LIBRETRO_LIB_DIR}
		doins out/"${LIBRETRO_CORE_NAME}"_balanced_libretro.so
		insinto "${LIBRETRO_DATA_DIR}"/info
		doins "${INFO_PATH}/${LIBRETRO_CORE_NAME}"_balanced_libretro.info
	fi
	if use profile_performance; then
		insinto ${LIBRETRO_LIB_DIR}
		doins out/"${LIBRETRO_CORE_NAME}"_performance_libretro.so
		insinto "${LIBRETRO_DATA_DIR}"/info
		doins "${INFO_PATH}/${LIBRETRO_CORE_NAME}"_performance_libretro.info
	fi
	if use profile_accuracy; then
		insinto ${LIBRETRO_LIB_DIR}
		doins out/"${LIBRETRO_CORE_NAME}"_accuracy_libretro.so
		insinto "${LIBRETRO_DATA_DIR}"/info
		doins "${INFO_PATH}/${LIBRETRO_CORE_NAME}"_accuracy_libretro.info
	fi
	prepgamesdirs
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		elog ""
		elog "You should put the following optional files in your 'system_directory' folder:"
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
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
