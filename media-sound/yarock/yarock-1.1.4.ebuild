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
	vlc? ( >=media-video/vlc-2.2.0 )
	>=dev-libs/qjson-0.8.1
	<media-libs/taglib-1.10
	>=net-libs/htmlcxx-0.85
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

	if use phonon; then
		# Workaround for phonon includes, they changed a while ago.
		if use qt5; then
			sed -i src/core/player/phonon/engine_phonon.h \
				-e "s:#include <phonon/mediasource.h>:#include <phonon4qt5/phonon/mediasource.h>:" \
				-e "s:#include <phonon/mediaobject.h>:#include <phonon4qt5/phonon/mediaobject.h>:" \
				-e "s:#include <phonon/audiooutput.h>:#include <phonon4qt5/phonon/audiooutput.h>:" \
				-e "s:#include <phonon/path.h>:#include <phonon4qt5/phonon/path.h>:" \
				-e "s:#include <phonon/effect.h>:#include <phonon4qt5/phonon/effect.h>:" \
				-e "s:#include <phonon/volumefadereffect.h>:#include <phonon4qt5/phonon/volumefadereffect.h>:" \
				|| die '"sed" failed.'
			sed -i src/core/player/phonon/engine_phonon.cpp \
				-e "s:#include <phonon/backendcapabilities.h>:#include <phonon4qt5/phonon/backendcapabilities.h>:" \
				-e "s:#include <phonon/effect.h>:#include <phonon4qt5/phonon/effect.h>:" \
				-e "s:#include <phonon/effectparameter.h>:#include <phonon4qt5/phonon/effectparameter.h>:" \
				|| die '"sed" failed.'
		else
			sed -i src/core/player/phonon/engine_phonon.h \
				-e "s:#include <phonon/mediasource.h>:#include <phonon4qt4/phonon/mediasource.h>:" \
				-e "s:#include <phonon/mediaobject.h>:#include <phonon4qt4/phonon/mediaobject.h>:" \
				-e "s:#include <phonon/audiooutput.h>:#include <phonon4qt4/phonon/audiooutput.h>:" \
				-e "s:#include <phonon/path.h>:#include <phonon4qt4/phonon/path.h>:" \
				-e "s:#include <phonon/effect.h>:#include <phonon4qt4/phonon/effect.h>:" \
				-e "s:#include <phonon/volumefadereffect.h>:#include <phonon4qt4/phonon/volumefadereffect.h>:" \
				|| die '"sed" failed.'
			sed -i src/core/player/phonon/engine_phonon.cpp \
				-e "s:#include <phonon/backendcapabilities.h>:#include <phonon4qt4/phonon/backendcapabilities.h>:" \
				-e "s:#include <phonon/effect.h>:#include <phonon4qt4/phonon/effect.h>:" \
				-e "s:#include <phonon/effectparameter.h>:#include <phonon4qt4/phonon/effectparameter.h>:" \
				|| die '"sed" failed.'
		fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_MPV=$(usex mpv ON OFF)
		-DENABLE_QT5=$(usex qt5 ON OFF)
		-DENABLE_PHONON=$(usex phonon ON OFF)
		-DENABLE_VLC=$(usex vlc ON OFF)
	)

	cmake-utils_src_configure
}
