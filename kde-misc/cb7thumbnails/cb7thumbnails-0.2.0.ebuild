# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="A Thumbnail creator for KDE 4 that enables previewing cb7 files"
HOMEPAGE="http://kde-apps.org/content/show.php/ComicBook+7zip+Thumbnail+Plugin?content=157716"
SRC_URI="http://kde-apps.org/CONTENT/content-files/157716-${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
	app-arch/p7zip
"
