# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Breath GTK2/3 Theme for Manjaro Linux"
HOMEPAGE="https://github.com/manjaro/artwork-breath-gtk"
SRC_URI="https://github.com/manjaro/artwork-breath-gtk/archive/da2706640f457f89de6c26312e391b244ff550b4.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"
S="${WORKDIR}/artwork-breath-gtk-da2706640f457f89de6c26312e391b244ff550b4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPENDS="x11-libs/gdk-pixbuf"

src_configure() {
	local mycmakeargs=(-DWITH_GTK3_VERSION=3.20)
	cmake-utils_src_configure
}
