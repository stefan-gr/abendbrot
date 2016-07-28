# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

MY_PN="Yarock"
MY_P="${MY_PN}_${PV}_source"
DESCRIPTION="Yarock is designed to provide an easy and pretty music browser."
HOMEPAGE="http://seb-apps.github.io/yarock/"
SRC_URI="https://launchpad.net/${PN}/1.x/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpv +phonon +qt5 vlc"

DEPEND="
	!qt5? (
		>=dev-qt/qtcore-4.8.7:4
		>=dev-qt/qtgui-4.8.7:4
		>=dev-qt/qtxmlpatterns-4.8.7:4
		>=dev-qt/qtsql-4.8.7:4[sqlite]
		>=dev-qt/qtdbus-4.8.7:4
		media-libs/phonon[qt4]
	)
	qt5? (
		>=dev-qt/qtcore-5.4.2:5
		>=dev-qt/qtgui-5.4.2-r1:5
		>=dev-qt/qtdbus-5.4.2:5
		>=dev-qt/qtsql-5.4.2:5[sqlite]
		>=dev-qt/qtxml-5.4.2:5
		>=dev-qt/qtnetwork-5.4.2:5
		>=dev-qt/qtwidgets-5.4.2:5
		>=dev-qt/qtconcurrent-5.4.2:5
		>=dev-qt/qtx11extras-5.4.2:5
		media-libs/phonon[qt5]
	)
	vlc? (
	    qt5? ( >=media-video/vlc-2.2.0[qt5] )
	    !qt5? ( >=media-video/vlc-2.2.0[qt4] )
	)
	>=dev-libs/qjson-0.8.1
	>=media-libs/taglib-1.9.1-r2
	>=net-libs/htmlcxx-0.85
	mpv? ( >=media-video/mpv-0.8.3-r1[libmpv] )
"

RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mpv phonon vlc )"

DOCS="CHANGES.md README.md"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable mpv)
		$(cmake-utils_use_enable qt5)
		$(cmake-utils_use_enable phonon)
		$(cmake-utils_use_enable vlc)
	)

	cmake-utils_src_configure
}
