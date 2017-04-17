# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Game editor similar to RPG Maker "
HOMEPAGE="https://easyrpg.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/EasyRPG/Editor-Qt.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/EasyRPG/Editor-Qt/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/Editor-Qt-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/liblcf:0
	dev-qt/qtmultimedia:5
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	dobin bin/easyrpg-editor
	insinto /usr/share/pixmaps
	newins src/share/easyrpg.png "${PN}.png"
	make_desktop_entry "easyrpg-editor %U" "EasyRPG Editor" "${PN}" "Development;"
}
