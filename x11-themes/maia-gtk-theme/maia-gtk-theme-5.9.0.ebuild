# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Maia GTK2/3 Theme for Manjaro Linux"
HOMEPAGE="https://github.com/manjaro/artwork-maia-gtk"
SRC_URI="https://github.com/manjaro/artwork-maia-gtk/archive/9f2c31c27d95e000958975d36c7c2b53ad2127b6.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"
S="${WORKDIR}/artwork-maia-gtk-9f2c31c27d95e000958975d36c7c2b53ad2127b6"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPENDS="x11-libs/gdk-pixbuf"

src_configure() {
	local mycmakeargs=(-DWITH_GTK3_VERSION=3.20)
	cmake-utils_src_configure
}
