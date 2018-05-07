# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION="2.8.12"
inherit cmake-utils

DESCRIPTION="Plasma 5 applet for controlling currently active window."
HOMEPAGE="https://store.kde.org/p/998910/"

LICENSE="GPL-2"
SLOT="5"
IUSE=""

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/kotelnik/plasma-applet-active-window-control.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/kotelnik/plasma-applet-active-window-control/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="primaryuri"
fi

DEPEND="kde-frameworks/kwindowsystem:5
	kde-frameworks/kwindowsystem:5
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	( dev-qt/qtquickcontrols:5[widgets] )
	dev-qt/qtgraphicaleffects:5"
RDEPEND="${DEPEND}"
