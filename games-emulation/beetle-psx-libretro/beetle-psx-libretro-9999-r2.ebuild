# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen PSX. (PlayStation, beetle version)"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE="+software opengl vulkan"

REQUIRED_USE="|| ( software opengl vulkan )"

DEPEND="
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=()

src_unpack() {
	# We need to add the different core names to the array
	# in order to let the eclass handle the install
	use software && LIBRETRO_CORE_NAME+=( mednafen_psx )
	use opengl || use vulkan && LIBRETRO_CORE_NAME+=( mednafen_psx_hw )
	libretro-core_src_unpack
}

src_compile() {
	if use software; then
		myemakeargs=(
			"HAVE_OPENGL=0"
			"HAVE_VULKAN=0"
			)
		libretro-core_src_compile
		# Move $TARGET to prevent emake clean deletion
		mv mednafen_psx_libretro.so mednafen_psx_libretro.so_temp
		emake clean
		mv mednafen_psx_libretro.so_temp mednafen_psx_libretro.so
		# Clear previous makeargs for next emake
		myemakeargs=( ${myemakeargs[@]/HAVE_*/} )
	fi
	if use opengl || use vulkan ; then
		myemakeargs=(
			$(usex opengl "HAVE_OPENGL=1" "HAVE_OPENGL=0")
			$(usex vulkan "HAVE_VULKAN=1" "HAVE_VULKAN=0")
			)
		libretro-core_src_compile
	fi
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
		ewarn ""
	fi
}
