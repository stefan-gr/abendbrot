# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libretro cmake-utils

DESCRIPTION="PPSSPP Assets for use with libretro"
HOMEPAGE="https://github.com/hrydgard/ppsspp"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hrydgard/ppsspp.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/hrydgard/ppsspp/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS=""
	S=${WORKDIR}/ppsspp-${PV}
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="x11-libs/libICE
	sys-libs/zlib
	x11-libs/libXt
	x11-libs/libXext
	media-libs/mesa"

ASSETS_DIR=${LIBRETRO_DATA_DIR}/PPSSPP

src_prepare() {
	#pretend to have sdl2 installed
	#we only need it to make cmake install the assets in the right directory
	sed -i CMakeLists.txt \
                -e 's:include(FindSDL2):set(SDL2_FOUND true):' \
                || die
	default_src_prepare
}

src_compile() {
	true
}

src_install() {
	dodir ${ASSETS_DIR}
	if [[ ${PV} == 9999 ]]; then
		rm -r "${BUILD_DIR}"/assets/lang/.git
	fi
	cp -R "${BUILD_DIR}"/assets/* "${D}${ASSETS_DIR}" || die "Install failed!"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PVR}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to copy the \"PPSSPP\" folder from \"${LIBRETRO_DATA_DIR}\""
		ewarn "into the retroarch \"system_directory\" folder of your user."
		ewarn "\$ mkdir -p ~/.local/share/retroarch/system/"
		ewarn "\$ cp -r ${ASSETS_DIR} ~/.local/share/retroarch/system/"
		ewarn ""
		ewarn ""
	fi
}
