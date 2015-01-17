# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 git-r3 qmake-utils

DESCRIPTION="A SVG-based theme engine for Qt4/Qt5 and KDE"
HOMEPAGE="http://kde-look.org/content/show.php/Kvantum?content=166241"
SRC_URI=""

EGIT_REPO_URI="git://github.com/tsujan/Kvantum.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	x11-libs/libXext
	qt5? ( dev-qt/qtcore:5 )
	qt5? ( dev-qt/qtgui:5 )
	qt5? ( dev-qt/qtsvg:5 )
	qt5? ( dev-qt/qtx11extras:5 )
"
RDEPEND="${DEPEND}"

S="${S}/Kvantum"
qt5_s="${WORKDIR}/qt5-build/Kvantum"


src_unpack() {
	if use qt5 ; then
		git-r3_fetch ${EGIT_REPO_URI} HEAD
		git-r3_checkout ${EGIT_REPO_URI} \
			"${WORKDIR}"/qt5-build
	fi

	git-r3_fetch
	git-r3_checkout
}

src_prepare() {
	#fixing color-scheme path
	sed -i style/style.pro \
		-e 's:/share/kde4/apps/color-schemes:/share/apps/color-schemes/:' \
		|| die

	if use qt5 ; then
		cd "${qt5_s}"
		sed -i style/style.pro \
			-e 's:/share/kde4/apps/color-schemes:/share/apps/color-schemes/:' \
			|| die
	fi
}

src_configure() {
	eqmake4

	if use qt5 ; then
		cd "${qt5_s}"
		eqmake5
	fi
}

src_compile() {
	emake

	if use qt5 ; then
		cd "${qt5_s}"
		emake
	fi
}

src_install() {
	INSTALL_ROOT="${D}" emake install

	if use qt5 ; then
		cd "${qt5_s}"
		INSTALL_ROOT="${D}" emake install
	fi
}