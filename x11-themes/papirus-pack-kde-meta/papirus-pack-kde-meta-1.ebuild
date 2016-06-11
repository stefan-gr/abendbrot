# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Papirus customization for KDE distros"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam"
SRC_URI=""
LICENSE=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+aurorae-theme bomi-skin +color-scheme gtk-theme +icon-theme k3b-theme kmail-theme +konsole-colorscheme kvantum-theme libreoffice-theme +look-and-feel +plasma-theme qtcurve-theme sddm-theme smplayer-theme vlc-theme +wallpapers +yakuake-theme"

DEPEND="aurorae-theme? ( x11-themes/papirus-aurorae-theme )
	bomi-skin? ( x11-themes/papirus-bomi-skin )
	color-scheme? ( x11-themes/papirus-color-scheme )
	gtk-theme? ( x11-themes/papirus-gtk-theme
				icon-theme? ( x11-themes/papirus-icon-theme-gtk ) )
	icon-theme? ( x11-themes/papirus-icon-theme-kde )
	k3b-theme? ( x11-themes/papirus-k3b-theme )
	kmail-theme? ( x11-themes/papirus-kmail-theme )
	konsole-colorscheme? ( x11-themes/papirus-konsole-colorscheme )
	kvantum-theme? ( x11-themes/papirus-kvantum-theme )
	libreoffice-theme? ( x11-themes/papirus-libreoffice-theme )
	look-and-feel? ( x11-themes/papirus-look-and-feel )
	plasma-theme? ( x11-themes/papirus-plasma-theme )
	qtcurve-theme? ( x11-themes/papirus-qtcurve-theme )
	sddm-theme? ( x11-themes/papirus-sddm-theme )
	smplayer-theme? ( x11-themes/papirus-smplayer-theme )
	vlc-theme? ( x11-themes/papirus-vlc-theme )
	wallpapers? ( x11-themes/papirus-wallpapers )
	yakuake-theme? ( x11-themes/papirus-yakuake-theme )"
RDEPEND="${DEPEND}"
