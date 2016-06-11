# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Look-and-feel package for modified and adaptive Papirus theme for KDE"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-look-and-feel"
SRC_URI=""
EGIT_REPO_URI="git://github.com/PapirusDevelopmentTeam/papirus-look-and-feel.git"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		kde-plasma/plasma-desktop"
