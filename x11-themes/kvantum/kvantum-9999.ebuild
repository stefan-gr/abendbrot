# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="A SVG-based theme engine for Qt4/Qt5 and KDE"
HOMEPAGE="https://github.com/tsujan/Kvantum"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/tsujan/Kvantum.git"
	SRC_URI=""
	KEYWORDS=""
	S="${S}/Kvantum"
	qt4_s="${WORKDIR}/qt4-build"
else
	SRC_URI="https://github.com/tsujan/Kvantum/archive/V${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Kvantum-${PV}/Kvantum"
	qt4_s="${WORKDIR}/qt4-build"
fi

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtx11extras:5
	x11-libs/libXext
	qt4? ( dev-qt/qtcore:4 )
	qt4? ( dev-qt/qtgui:4 )
	qt4? ( dev-qt/qtsvg:4 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare

	# Creating seperate dir for qt4 build
	if use qt4 ; then
		cp -r "${S}" "${qt4_s}"
	fi
}

src_configure() {
	eqmake5

	if use qt4 ; then
		cd "${qt4_s}"
		eqmake4
	fi
}

src_compile() {
	emake

	if use qt4 ; then
		cd "${qt4_s}"
		emake
	fi
}

src_install() {
	if use qt4 ; then
		cd "${qt4_s}"
		INSTALL_ROOT="${D}" emake install
		cd "${S}"
	fi

	INSTALL_ROOT="${D}" emake install
}
