# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5

DESCRIPTION="A KDE thumbnail generator for the ePub file format."
HOMEPAGE="https://www.linux-apps.com/content/show.php/KDE+ePub+Thumbnailer?content=151210"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1460972259/151210-${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="5"
IUSE="debug"

RDEPEND="
	$(add_frameworks_dep kio)
	$(add_frameworks_dep karchive)
"
