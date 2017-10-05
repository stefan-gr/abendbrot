# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Meta ebuild for all relevant arc themes"
HOMEPAGE="https://github.com/horst3180/Arc-theme"
SRC_URI=""
LICENSE="metapackage"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk +plasma"

DEPEND="gtk? ( x11-themes/arc-theme )
		plasma? ( x11-themes/arc-kde )"
RDEPEND="${DEPEND}"
