# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="A KDE thumbnail generator for the ePub file format."
HOMEPAGE="http://kde-apps.org/content/show.php/KDE+ePub+Thumbnailer?content=151210"
SRC_URI="http://kde-apps.org/CONTENT/content-files/151210-${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdebase-kioslaves)
"
