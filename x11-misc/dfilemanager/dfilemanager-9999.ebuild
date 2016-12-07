# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="A QT based crossplatform File browser"
HOMEPAGE="http://dfilemanager.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="git://git.code.sf.net/p/dfilemanager/code"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="qt5"

DEPEND="sys-apps/file
	x11-libs/libX11
	media-gfx/exiv2
	media-video/ffmpegthumbnailer
	qt5? ( kde-frameworks/solid
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
		dev-qt/qtopengl:5
		dev-qt/qtxml:5
		dev-qt/qtdbus:5
		app-text/poppler[qt5]
		)
	!qt5? ( kde-base/kdelibs
		dev-qt/qtgui:4
		app-text/poppler[qt4] )
	"
RDEPEND="${DEPEND}"

src_prepare() {
	for i in plugins/*/CMakeLists.txt; do
		sed -i "s|LIBRARY DESTINATION lib/dfm)|LIBRARY DESTINATION $(get_libdir)/dfm)|g" $i
	done
	default_src_prepare
}
src_configure() {
	local mycmakeargs=(
		-DQT5BUILD="$(usex qt5)"
	)
	cmake-utils_src_configure
}
