# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

# This ebuild provides the default RetroPie theme implemented by the script at:
# https://github.com/petrockblog/RetroPie-Setup/blob/master/scriptmodules/supplementary/emulationstation_theme_simple.sh
DESCRIPTION="Default RetroPie EmulationStation theme"
HOMEPAGE="https://github.com/nilsbyte/simple"
SRC_URI=""
EGIT_REPO_URI="git://github.com/nilsbyte/simple.git"

LICENSE="CC-BY-NC-SA-4.0"
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
	rm -R readme.txt .git || die '"rm" failed.'

	# Install all remaining files and subdirectories.
	insinto /etc/emulationstation/themes/simple
	doins -r *
}
