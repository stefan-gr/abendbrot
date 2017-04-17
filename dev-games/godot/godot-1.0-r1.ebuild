# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils scons-utils

DESCRIPTION="A advanced, feature packed, multi-platform 2D and 3D game engine."
HOMEPAGE="http://www.godotengine.org"
SRC_URI="https://github.com/godotengine/godot/archive/${PV}-stable.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+openssl +freetype"

DEPEND=">=dev-util/scons-2.3.0"

RDEPEND="
	freetype? ( >=media-libs/freetype-2.5.3-r1:2 )
	>=media-libs/mesa-10.2.8[gles2]
	>=media-libs/alsa-lib-1.0.28
	virtual/glu
	openssl? ( >=dev-libs/openssl-1.0.1j:0 )
	>=x11-libs/libXcursor-1.1.14"

S="${WORKDIR}/${PN}-${PV}-stable"

src_configure() {
	MYSCONS=(
		CC="$(tc-getCC)"
		platform=x11
		freetype=$(usex freetype)
		openssl=$(usex openssl)
	)
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	dobin bin/godot.*
	if [[ "${ARCH}" == "amd64" ]]; then
		make_desktop_entry godot.x11.tools.64 Godot
		with_desktop_entry=1
	fi

	if [[ "${ARCH}" == "x86" ]]; then
		make_desktop_entry godot.x11.tools.32 Godot
		with_desktop_entry=1
	fi

	if ! [[ "${with_desktop_entry}" == "1" ]]; then
		elog "Couldn't detect running architecture to create a desktop file."
	fi
}
