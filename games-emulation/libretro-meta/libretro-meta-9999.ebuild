# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="http://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"
IUSE="bnes +bsnes +desmume +fb-alpha +fceu-next +gambatte +genplus +handy imame4all \
+mame +mednafen-gba +mednafen-ngp +mednafen-pce-fast +mednafen-psx +mednafen-snes \
+mednafen-vb +mednafen-wswan +meteor +mupen64plus +nestopia +nxengine +pcsx-rearmed \
+picodrive pocketsnes +prboom +quicknes +scummvm +snes9x +snes9x-next +stella +tyrquake \
+vba-next +vbam"

KEYWORDS="~amd64 ~x86"

RDEPEND="bnes? ( >=games-emulation/bnes-libretro-9999 )
		bsnes? ( >=games-emulation/bsnes-libretro-9999 )
		desmume? ( >=games-emulation/desmume-libretro-9999 )
		fb-alpha? ( >=games-emulation/fb-alpha-libretro-9999 )
		fceu-next? ( >=games-emulation/fceu-next-libretro-9999 )
		gambatte? ( >=games-emulation/gambatte-libretro-9999 )
		genplus? ( >=games-emulation/genplus-libretro-9999 )
		handy? ( >=games-emulation/handy-libretro-9999 )
		imame4all? ( >=games-emulation/imame4all-libretro-9999 )
		mame? ( >=games-emulation/mame-libretro-9999 )
		mednafen-gba? ( >=games-emulation/mednafen-gba-libretro-9999 )
		mednafen-ngp? ( >=games-emulation/mednafen-ngp-libretro-9999 )
		mednafen-pce-fast? ( >=games-emulation/mednafen-pce-fast-libretro-9999 )
		mednafen-psx? ( >=games-emulation/mednafen-psx-libretro-9999 )
		mednafen-snes? ( >=games-emulation/mednafen-snes-libretro-9999 )
		mednafen-vb? ( >=games-emulation/mednafen-vb-libretro-9999 )
		mednafen-wswan? ( >=games-emulation/mednafen-wswan-libretro-9999 )
		meteor? ( >=games-emulation/meteor-libretro-9999 )
		mupen64plus? ( >=games-emulation/mupen64plus-libretro-9999 )
		nestopia? ( >=games-emulation/nestopia-libretro-9999 )
		nxengine? ( >=games-emulation/nxengine-libretro-9999 )
		pcsx-rearmed? ( >=games-emulation/pcsx-rearmed-libretro-9999 )
		picodrive? ( >=games-emulation/picodrive-libretro-9999 )
		pocketsnes? ( >=games-emulation/pocketsnes-libretro-9999 )
		prboom? ( >=games-emulation/prboom-libretro-9999 )
		quicknes? ( >=games-emulation/quicknes-libretro-9999 )
		scummvm? ( >=games-emulation/scummvm-libretro-9999 )
		snes9x? ( >=games-emulation/snes9x-libretro-9999 )
		snes9x-next? ( >=games-emulation/snes9x-next-libretro-9999 )
		stella? ( >=games-emulation/stella-libretro-9999 )
		tyrquake? ( >=games-emulation/tyrquake-libretro-9999 )
		vba-next? ( >=games-emulation/vba-next-libretro-9999 )
		vbam? ( >=games-emulation/vbam-libretro-9999 )"
DEPEND=""
