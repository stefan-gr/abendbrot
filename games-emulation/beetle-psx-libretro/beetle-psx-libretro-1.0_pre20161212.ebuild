# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libretro-core

DESCRIPTION="libretro implementation of Mednafen PSX. (PlayStation, beetle version)"
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
SRC_URI="https://github.com/libretro/beetle-psx-libretro/archive/f12cc2ff3674d95d7e0fa1dd9f6398b0eaf57ca7.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

S="${WORKDIR}/beetle-psx-libretro-f12cc2ff3674d95d7e0fa1dd9f6398b0eaf57ca7"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/beetle-psx-libretro.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug opengl vulkan"

DEPEND="
	opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=beetle_psx

src_compile() {
	filter-flags -O*
	use opengl || use vulkan && append-cppflags -DHAVE_HW
	local myemakeargs=(
		$(usex debug "DEBUG=1" "DEBUG=0")
		$(usex opengl "HAVE_OPENGL=1" "HAVE_OPENGL=0")
		$(usex vulkan "HAVE_VULKAN=1" "HAVE_VULKAN=0")
	)
	emake "${myemakeargs[@]}" || die "emake failed"
}

src_install() {
	mv "${S}"/mednafen_psx*_libretro.so "${S}"/beetle_psx_libretro.so
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
