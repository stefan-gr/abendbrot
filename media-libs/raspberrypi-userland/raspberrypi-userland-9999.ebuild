# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit cmake-utils flag-o-matic git-r3

DESCRIPTION="Raspberry Pi userspace tools and libraries"
HOMEPAGE="https://github.com/raspberrypi/userland"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND=""

EGIT_REPO_URI="https://github.com/raspberrypi/userland"

#PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_install() {
	cmake-utils_src_install

	dosym libGLESv2.so /opt/vc/lib/libGLESv1_CM.so

	doenvd "${FILESDIR}"/04${PN}

	# enable dynamic switching of the GL implementation
	dodir /usr/lib/opengl
	dosym ../../../opt/vc /usr/lib/opengl/${PN}

	# add pkg-config
	dosym ../../../opt/vc/lib/pkgconfig/bcm_host.pc /usr/lib/pkgconfig/bcm_host.pc
	dosym ../../../opt/vc/lib/pkgconfig/brcmegl.pc /usr/lib/pkgconfig/brcmegl.pc
	dosym ../../../opt/vc/lib/pkgconfig/brcmglesv2.pc /usr/lib/pkgconfig/brcmglesv2.pc
	dosym ../../../opt/vc/lib/pkgconfig/brcmvg.pc /usr/lib/pkgconfig/brcmvg.pc
	dosym ../../../opt/vc/lib/pkgconfig/mmal.pc /usr/lib/pkgconfig/mmal.pc
	dosym ../../../opt/vc/lib/pkgconfig/vcsm.pc /usr/lib/pkgconfig/vcsm.pc
	dosym ../../../opt/vc/lib/pkgconfig/vg.pc /usr/lib/pkgconfig/vg.pc

	# tell eselect opengl that we do not have libGL
	touch "${ED}"/opt/vc/.gles-only

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/92-local-vchiq-permissions.rules
}
