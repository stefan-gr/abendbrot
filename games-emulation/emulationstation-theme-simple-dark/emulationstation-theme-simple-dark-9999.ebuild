# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

# This ebuild provides the core-specific half of the default RetroPie theme
# implemented by the "RetroPie-Setup" project's
# "scriptmodules/supplementary/emulationstation_theme_simple.sh" script.
DESCRIPTION="Dark-on-light RetroPie EmulationStation theme"
HOMEPAGE="https://github.com/nolageek/simple-dark"
SRC_URI=""
EGIT_REPO_URI="git://github.com/nolageek/simple-dark.git"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	# Install documentation.
	dodoc README.md

	# Prevent documentation and the ".git" subdirectory from being installed
	# below.
	rm -R README.md .git || die '"rm" failed.'

	# Install all remaining files and subdirectories.
	insinto /etc/emulationstation/themes/simple-dark
	doins -r *
}
