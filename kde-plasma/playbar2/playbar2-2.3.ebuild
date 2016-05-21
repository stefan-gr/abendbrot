# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

MY_P="PlayBar2-${PV}"

DESCRIPTION="Client MPRIS2, allows you to control your favorite media player"
HOMEPAGE="http://kde-look.org/content/show.php/PlayBar2?content=168944"
SRC_URI="https://github.com/audoban/PlayBar2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="5"
IUSE=""

DEPEND="$(add_frameworks_dep plasma)"
RDEPEND="
	$(add_plasma_dep plasma-workspace)
"

S="${WORKDIR}/${MY_P}"
