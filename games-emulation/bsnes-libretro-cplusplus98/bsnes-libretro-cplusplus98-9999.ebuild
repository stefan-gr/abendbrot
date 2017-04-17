# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of bSNES/higan. (Super Nintendo Entertainment System)"
HOMEPAGE="https://github.com/libretro/bsnes-libretro-cplusplus98"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="profile_accuracy +profile_balanced profile_performance"

REQUIRED_USE="|| ( profile_accuracy profile_balanced profile_performance )"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=()

src_unpack() {
	# We need to add the different core names to the array
	# in order to let the eclass handle the install
	use profile_accuracy && LIBRETRO_CORE_NAME+=( "${PN%-libretro}"_accuracy )
	use profile_balanced && LIBRETRO_CORE_NAME+=( "${PN%-libretro}"_balanced )
	use profile_performance && LIBRETRO_CORE_NAME+=( "${PN%-libretro}"_performance )
	libretro-core_src_unpack
}

src_compile() {
	myemakeargs=( "ui=target-libretro" )
	if use profile_balanced; then
		myemakeargs+=( "profile=balanced" )
		libretro-core_src_compile
		myemakeargs=( ${myemakeargs[@]/profile=*/} )
	# Never forget to move the file where the eclass expect it
	mv out/"${PN%-libretro}"_balanced_libretro.so .
	fi
	if use profile_performance; then
		emake clean
		myemakeargs+=( "profile=performance" )
		libretro-core_src_compile
		myemakeargs=( ${myemakeargs[@]/profile=*/} )
	# Never forget to move the file where the eclass expect it
	mv out/"${PN%-libretro}"_performance_libretro.so .
	fi
	if use profile_accuracy; then
		emake clean
		myemakeargs+=( "profile=accuracy" )
		libretro-core_src_compile
		myemakeargs=( ${myemakeargs[@]/profile=*/} )
	# Never forget to move the file where the eclass expect it
	mv out/"${PN%-libretro}"_accuracy_libretro.so .
	fi
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
		ewarn ""
	fi
}
