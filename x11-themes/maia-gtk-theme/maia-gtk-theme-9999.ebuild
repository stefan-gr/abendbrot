# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Maia GTK2/3 Theme for Manjaro Linux"
HOMEPAGE="https://github.com/manjaro/artwork-maia-gtk"
EGIT_REPO_URI="https://github.com/manjaro/artwork-maia-gtk.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

DEPENDS="x11-libs/gdk-pixbuf"

src_configure() {
	local mycmakeargs=(-DWITH_GTK3_VERSION=3.20)
	cmake-utils_src_configure
}
