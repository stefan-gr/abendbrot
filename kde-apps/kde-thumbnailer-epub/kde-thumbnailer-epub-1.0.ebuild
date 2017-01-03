# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde4-base

DESCRIPTION="A KDE thumbnail generator for the ePub file format."
HOMEPAGE="https://www.linux-apps.com/content/show.php/KDE+ePub+Thumbnailer?content=151210"
SRC_URI="https://github.com/Caig/kde-thumbnailer-epub/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdeapps_dep kdebase-kioslaves)
"
