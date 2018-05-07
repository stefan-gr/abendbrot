# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="EmulationStation theme simplified-static-canela"
HOMEPAGE="https://github.com/RetroPie/es-theme-simplified-static-canela"
SRC_URI=""
EGIT_REPO_URI="https://github.com/RetroPie/es-theme-simplified-static-canela.git"

LICENSE="CC-BY-NC-SA-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	# Install documentation.
	dodoc readme.txt

	# Prevent documentation and the ".git" subdirectory from being installed
	# below.
	rm -R readme.txt .git* || die '"rm" failed.'

	# Install all remaining files and subdirectories.
	insinto /etc/emulationstation/themes/simplified-static-canela
	doins -r *
}
