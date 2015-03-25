# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils scons-utils

DESCRIPTION="A advanced, feature packed, multi-platform 2D and 3D game engine."
HOMEPAGE="http://www.godotengine.org"
SRC_URI="https://github.com/okamstudio/godot/archive/${PV}-stable.tar.gz"
RESTRICT="primaryuri"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-util/scons-2.3.0"

RDEPEND=">=media-libs/mesa-10.2.8
	>=media-libs/freetype-2.5.3-r1:2
	>=media-libs/alsa-lib-1.0.28
	virtual/glu
	>=x11-libs/libXcursor-1.1.14"

S="${WORKDIR}/${PN}-${PV}-stable"

src_configure() {
	myesconsargs=(
		platform=x11
	)
}

src_compile() {
	escons
}

src_install() {
	dobin bin/godot.x11.tools*
	if [[ "${ARCH}" == "amd64" ]]; then
		make_desktop_entry godot.x11.tools.64 Godot
		with_desktop_entry=1
	fi

	#this is just a wild guess, change to your liking and open a issue at github for me, thanks.
	if [[ "${ARCH}" == "x86" ]]; then
		make_desktop_entry godot.x11.tools.32 Godot
		with_desktop_entry=1
	fi

	if ! [[ "${with_desktop_entry}" == "1" ]]; then
		elog "Couldn't detect running architecture to create a desktop file."
	fi
}