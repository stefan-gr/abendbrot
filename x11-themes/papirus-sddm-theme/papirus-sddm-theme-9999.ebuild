# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Papirus theme for SDDM"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-sddm-theme"
SRC_URI=""
EGIT_REPO_URI="git://github.com/PapirusDevelopmentTeam/papirus-sddm-theme.git"
LICENSE="CC-BY-SA-4.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		x11-misc/sddm"
