# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION=2.8.11

inherit cmake-utils

DESCRIPTION="A style to bend Qt applications to look like they belong into GNOME Shell"
HOMEPAGE="https://github.com/MartinBriza/adwaita-qt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/MartinBriza/adwaita-qt.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/MartinBriza/adwaita-qt/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
qt4_s="${WORKDIR}/qt4-build"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libXext
	qt4? ( dev-qt/qtcore:4 )
	qt4? ( dev-qt/qtdbus:4 )
	qt4? ( dev-qt/qtgui:4 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare

	# Creating seperate dir for qt4 build
	if use qt4 ; then
		cp -r "${S}" "${qt4_s}"
	fi
}

src_configure() {
	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}${PREFIX}"
	)
	cmake-utils_src_configure

	if use qt4 ; then
		cd "${qt4_s}"
		BUILD_DIR="${WORKDIR}/${qt4_s}"_build
		local mycmakeargs=(
			-DCMAKE_INSTALL_PREFIX="${EPREFIX}${PREFIX}"
			-DUSE_QT4=ON
		)
		cmake-utils_src_configure
		BUILD_DIR="${WORKDIR}/${P}"_build
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use qt4 ; then
		cd "${qt4_s}"
		BUILD_DIR="${WORKDIR}/${qt4_s}"_build
		cmake-utils_src_compile
		BUILD_DIR="${WORKDIR}/${P}"_build
	fi
}

src_install() {
	if use qt4 ; then
		cd "${qt4_s}"
		BUILD_DIR="${WORKDIR}/${qt4_s}"_build
		cmake-utils_src_install
		BUILD_DIR="${WORKDIR}/${P}"_build
		cd "${S}"
	fi

	cmake-utils_src_install
}
