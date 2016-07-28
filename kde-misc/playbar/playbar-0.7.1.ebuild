# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde4-base

MY_P="PlayBar-${PV}"

DESCRIPTION="Client Mpris2, allows you to control your favorite media player."
HOMEPAGE="http://kde-look.org/content/show.php/PlayBar?content=165396"
SRC_URI="https://github.com/audoban/PlayBar/archive/v${PV}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${MY_P}"
