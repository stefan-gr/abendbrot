# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Papirus customization for KDE distros"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam"
SRC_URI=""
LICENSE="metapackage"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+discontinued +icon-theme libreoffice-theme smplayer-theme"

DEPEND="discontinued? ( x11-themes/papirus-archive )
	icon-theme? ( x11-themes/papirus-icon-theme )
	libreoffice-theme? ( x11-themes/papirus-libreoffice-theme )
	smplayer-theme? ( x11-themes/papirus-smplayer-theme )"
RDEPEND="${DEPEND}"
