# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 gnome2-utils

DESCRIPTION="Papirus customization for KDE distros"
HOMEPAGE="https://github.com/varlesh/papirus-pack-kde"
SRC_URI=""
EGIT_REPO_URI="git://github.com/varlesh/papirus-pack-kde.git"
LICENSE="CC-BY-SA-4.0 GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+aurorae-themes +color-scheme gtk-themes +icons kmail-theme +konsole-colorscheme +plasma-themes +yakuake-skins qtcurve"

DEPEND="aurorae-themes? ( || ( kde-plasma/kwin kde-base/kwin ) )
	icons? ( kde-plasma/breeze:5
		kde-frameworks/oxygen-icons:* )
	gtk-themes? ( x11-themes/gtk-engines-murrine
		    x11-libs/gtk+:3 )
	kmail-theme? ( || ( kde-apps/kdepim:5[kdepim_features_kmail] kde-apps/kmail ) )
	konsole-colorscheme? ( kde-apps/konsole:* )
	yakuake-skins? ( kde-misc/yakuake:* )
	qtcurve? ( x11-themes/qtcurve )"
RDEPEND="${DEPEND}"

src_install() {
	if use aurorae-themes; then
		insinto /usr/share/aurorae/themes
		doins -r kde-pack/aurorae-themes/Papirus
		doins -r kde-pack/aurorae-themes/Papirus-Transparent
		doins -r kde-pack/aurorae-themes/PapirusDark
		doins -r kde-pack/aurorae-themes/PapirusDark-Transparent
	fi
	if use color-scheme; then
		insinto /usr/share/color-schemes/
		doins kde-pack/color-schemes/Papirus.colors
		doins kde-pack/color-schemes/PapirusDark.colors
	fi
	if use gtk-themes; then
		insinto /usr/share/themes/
		doins -r kde-pack/gtk-themes/papirus
		doins -r kde-pack/gtk-themes/papirus-dark
	fi
	if use icons; then
		insinto /usr/share/icons/
		doins -r kde-pack/icons/papirus
		doins -r kde-pack/icons/papirus-dark
		doins -r kde-pack/icons/papirus-black-panel
		doins -r gtk-icons/Papirus-Dark-GTK
		doins -r gtk-icons/Papirus-GTK
	fi
	if use kmail-theme; then
		insinto /usr/share/messageviewer/themes/
		doins -r kde-pack/kmail-theme/papirus
		doins -r kde-pack/kmail-theme/papirus-dark
	fi
	if use konsole-colorscheme; then
		insinto /usr/share/konsole
		doins kde-pack/konsole-colorschemes/Papirus.colorscheme
		doins kde-pack/"konsole-colorschemes/Papirus Dark.colorscheme"
	fi
	if use plasma-themes; then
		insinto /usr/share/plasma/desktoptheme/
		doins -r kde-pack/plasma-themes/papirus
		doins -r kde-pack/plasma-themes/papirus-dark
	fi
	if use qtcurve; then
		insinto /usr/share/QtCurve/
		doins kde-pack/QtCurve/Papirus.qtcurve
		doins kde-pack/QtCurve/Papirus_Dark.qtcurve
		doins kde-pack/QtCurve/Papirus_Dark_Transparent.qtcurve
		doins kde-pack/QtCurve/Papirus_Transparent.qtcurve
	fi
	if use yakuake-skins; then
		insinto /usr/share/yakuake/skins/
		doins -r kde-pack/yakuake-skins/papirus
		doins -r kde-pack/yakuake-skins/papirus-dark
	fi
	if use color-scheme && use icons && use plasma-themes; then
		insinto /usr/share/plasma/look-and-feel/
		doins -r kde-pack/look-and-feel/com.github.varlesh.papirus
		doins -r kde-pack/look-and-feel/com.github.varlesh.papirus-dark
	fi
	dodoc README.md
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
