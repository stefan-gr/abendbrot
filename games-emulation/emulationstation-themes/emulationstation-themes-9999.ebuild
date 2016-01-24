# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# This is a placeholder ebuild simplifying installation of EmulationStation
# themes by abusing USE flags. Needless to say, this won't be hitting the
# Portage tree anytime soon.
DESCRIPTION="EmulationStation themes"
HOMEPAGE="http://emulationstation.org"
SRC_URI=""

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="+simple simple-dark"

RDEPEND="
	simple?      ( games-emulation/emulationstation-theme-simple )
	simple-dark? ( games-emulation/emulationstation-theme-simple-dark )"
DEPEND=""
