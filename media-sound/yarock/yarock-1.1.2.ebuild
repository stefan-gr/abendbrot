# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

MY_PN="Yarock"
MY_P="${MY_PN}_${PV}_source"
DESCRIPTION="Yarock is designed to provide an easy and pretty music browser based on cover art."
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
	)
	vlc? (
	    qt5? (
		>=media-video/vlc-2.2.0[qt5]
	    )
	    !qt5? (
		>=media-video/vlc-2.2.0[qt4]
	    )
	)
	media-libs/phonon
	>=dev-libs/qjson-0.8.1
	>=media-libs/taglib-1.9.1-r2
	mpv? ( >=media-video/mpv-0.8.3-r1[libmpv] )
"

RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mpv phonon vlc )"

DOCS="CHANGES README"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	#fix library path
	sed -i CMakeLists.txt \
		-e "s:/lib/yarock:/$(get_libdir)/yarock:" \
		|| die
	sed -i src/core/player/mpv/CMakeLists.txt \
		-e "s:/lib:/$(get_libdir):" \
		|| die
	sed -i src/core/player/phonon/CMakeLists.txt \
		-e "s:/lib:/$(get_libdir):" \
		|| die
	sed -i src/core/player/vlc/CMakeLists.txt \
		-e "s:/lib:/$(get_libdir):" \
		|| die

	cmake-utils_src_prepare 
}

src_configure() {
        local mycmakeargs=(
                $(cmake-utils_use_enable mpv)
                $(cmake-utils_use_enable qt5)
                $(cmake-utils_use_enable phonon)
                $(cmake-utils_use_enable vlc)
        )

        cmake-utils_src_configure
}


