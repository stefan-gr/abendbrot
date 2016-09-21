# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde4-base

DESCRIPTION="A Thumbnail creator for KDE 4 that enables previewing cb7 files"
HOMEPAGE="https://www.linux-apps.com/content/show.php/ComicBook+7zip+Thumbnail+Plugin?content=157716"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1460971390/157716-${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdeapps_dep kdebase-kioslaves)
	app-arch/p7zip
"
