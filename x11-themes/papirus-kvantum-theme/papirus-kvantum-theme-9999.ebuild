# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Kvantum theme for Papirus"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-kvantum-theme"
SRC_URI=""
EGIT_REPO_URI="git://github.com/PapirusDevelopmentTeam/papirus-kvantum-theme.git"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		x11-themes/kvantum"
