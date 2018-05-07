# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Papirus theme for SMPlayer"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-smplayer-theme"
SRC_URI=""
EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/papirus-smplayer-theme.git"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		media-video/smplayer"
