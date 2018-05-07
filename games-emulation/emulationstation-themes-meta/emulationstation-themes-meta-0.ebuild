# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="EmulationStation themes meta package"
HOMEPAGE="https://github.com/RetroPie/EmulationStation"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="+carbon +carbon-centered +carbon-nometa +clean-look +color-pi +nbba +pixel +simple +simple-dark +simplified-static-canela +turtle-pi +zoid"

RDEPEND="
	carbon?      ( games-emulation/es-theme-carbon )
	carbon-centered?      ( games-emulation/es-theme-carbon-centered )
	carbon-nometa?      ( games-emulation/es-theme-carbon-nometa )
	clean-look?      ( games-emulation/es-theme-clean-look )
	color-pi?      ( games-emulation/es-theme-color-pi )
	nbba?      ( games-emulation/es-theme-nbba )
	pixel?      ( games-emulation/es-theme-pixel )
	simple?      ( games-emulation/es-theme-simple )
	simple-dark?      ( games-emulation/es-theme-simple-dark )
	simplified-static-canela?      ( games-emulation/es-theme-simplified-static-canela )
	turtle-pi?      ( games-emulation/es-theme-turtle-pi )
	zoid? ( games-emulation/es-theme-zoid )
"
DEPEND=""
