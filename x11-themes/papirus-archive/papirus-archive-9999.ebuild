# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Discontinued papirus projects"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/ARCHIVE"
SRC_URI=""
EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/ARCHIVE.git"
LICENSE="CC-BY-SA-4.0"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share
	doins -r kde/Kvantum kde/aurorae kde/color-schemes kde/konsole kde/messageviewer kde/plasma kde/wallpapers kde/yakuake
	insinto /usr/share/sddm/themes/
	doins -r sddm/papirus
	insinto /usr/share/vlc/skins2
	doins vlc/Papirus.vlt
	insinto /usr/share/themes/papirus
	doins -r gtk/papirus318/assets gtk/papirus318/gtk-2.0 gtk/papirus318/gtk-3.0 gtk/papirus318/plank gtk/papirus310/index.theme
}
