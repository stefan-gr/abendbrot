# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3 kde5

DESCRIPTION="A maclike style for qt4/qt5/kde4/kde5"
HOMEPAGE="http://sourceforge.net/p/styleproject"
SRC_URI=""
EGIT_REPO_URI="git://git.code.sf.net/p/styleproject/code.git"

LICENSE=""

SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="+qt5"

DEPEND="!qt5? ( dev-qt/qtdbus:4
                kde-base/kwin
        )
        qt5? (
                dev-qt/qtdbus:5 
                dev-qt/qtx11extras
                $(add_plasma_dep kwin)
        )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DQT5BUILD="$(usex qt5)"
		-DLIBDIR="$(get_libdir)"
	)
	cmake-utils_src_configure
}
