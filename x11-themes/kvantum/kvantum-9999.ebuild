# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib qt4-r2 git-r3

DESCRIPTION="A Linux SVG-based theme engine for Qt4 and KDE4"
HOMEPAGE="http://kde-look.org/content/show.php/Kvantum?content=166241"
SRC_URI=""

EGIT_REPO_URI="git://github.com/tsujan/Kvantum.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
"
RDEPEND="${DEPEND}"

S="${S}/Kvantum"

src_configure() {
	eqmake4
}

src_compile() {
	emake
}

src_install() {
	insinto /usr/$(get_libdir)/qt4/plugins/styles
	doins style/libkvantum.so
	insinto /usr/share/apps/color-schemes/
	doins color/Kvantum.colors
	dodoc ChangeLog doc/Theme-Config.pdf doc/Theme-Making.pdf
	dobin kvantumpreview/kvantumpreview
}