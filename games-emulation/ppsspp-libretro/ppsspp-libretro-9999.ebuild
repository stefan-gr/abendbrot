# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="libretro implementation of PPSSPP. (PlayStation Portable/PSP)"
HOMEPAGE="https://github.com/libretro/libretro-ppsspp"
SRC_URI=""

EGIT_REPO_URI="https://github.com/libretro/libretro-ppsspp.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="x11-libs/libICE
	sys-libs/zlib
	x11-libs/libXt
	x11-libs/libXext
	media-libs/mesa"
DEPEND=""

src_unpack() {
	git-r3_fetch https://github.com/libretro/libretro-super.git HEAD
	git-r3_checkout https://github.com/libretro/libretro-super.git \
		"${WORKDIR}"/infos
	git-r3_fetch
	git-r3_checkout
}

src_configure() {
	local mycmakeargs=(
		-DLIBRETRO=ON
	)
	cmake-utils_src_configure
}

src_install() {
	insinto /usr/$(get_libdir)/libretro
	newins "${BUILD_DIR}"/lib/libPPSSPPLibretro.so ppsspp_libretro.so
	insinto /usr/share/libretro/info/
	doins "${WORKDIR}"/infos/dist/info/ppsspp_libretro.info
	dodir /usr/share/libretro/PPSSPP/
	cp -R "${BUILD_DIR}"/assets/* "${D}/usr/share/libretro/PPSSPP/" || die "Install failed!"
}

pkg_preinst() {
	if ! has_version "=${CATEGORY}/${PN}-${PV}"; then
		first_install="1"
	fi
}

pkg_postinst() {
	if [[ "${first_install}" == "1" ]]; then
		ewarn ""
		ewarn "You need to copy the \"PPSSPP\" folder from \"/usr/share/libretro\""
		ewarn "into the retroarch \"system_directory\" folder of your user."
		ewarn "\$ mkdir -p ~/.local/share/retroarch/system/"
		ewarn "\$ cp -r /usr/share/libretro/PPSSPP/ ~/.local/share/retroarch/system/"
		ewarn ""
		ewarn "This message will only be displayed once!"
		ewarn ""
	fi
}
