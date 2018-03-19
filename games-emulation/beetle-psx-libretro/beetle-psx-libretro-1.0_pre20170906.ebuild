# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBRETRO_COMMIT_SHA="05892b19025af2084b09e1b9194170a4290e720f"
inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen PSX. (PlayStation, beetle version)"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
KEYWORDS="amd64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="opengl vulkan"

DEPEND="
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=mednafen_psx

src_compile() {
	use opengl || use vulkan && append-cppflags -DHAVE_HW
	local myemakeargs=(
		$(usex opengl "HAVE_OPENGL=1" "HAVE_OPENGL=0")
		$(usex vulkan "HAVE_VULKAN=1" "HAVE_VULKAN=0")
	)
	libretro-core_src_compile
}

src_install() {
	mv "${S}"/mednafen_psx*_libretro.so "${S}"/mednafen_psx_libretro.so
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
		ewarn ""
	fi
}
