# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="http://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"
IUSE="+2048 +4do +beetle-psx bnes +bsnes +desmume dolphin +fba fceu-next +gambatte +genplus \
+handy mame mame2000 mednafen-gba +mednafen-ngp +mednafen-pce-fast \
mednafen-snes +mednafen-vb +mednafen-wswan meteor +mgba +mupen64plus +nestopia +nxengine \
pcsx-rearmed +mednafen-supergrafx picodrive pocketsnes ppsspp +prboom +prosystem +psp1 quicknes +scummvm \
snes9x snes9x-next +stella tgbdual +tyrquake vba-next vbam +yabause"

KEYWORDS="amd64 x86"

RDEPEND="2048? ( games-emulation/2048-libretro )
		4do? ( games-emulation/4do-libretro )
		beetle-psx? ( games-emulation/beetle-psx-libretro )
		bnes? ( games-emulation/bnes-libretro )
		bsnes? ( games-emulation/bsnes-libretro )
		desmume? ( games-emulation/desmume-libretro )
		dolphin? ( games-emulation/dolphin-libretro )
		fba? ( games-emulation/fba-libretro )
		fceu-next? ( games-emulation/fceu-next-libretro )
		gambatte? ( games-emulation/gambatte-libretro )
		genplus? ( games-emulation/genplus-libretro )
		handy? ( games-emulation/handy-libretro )
		mame? ( games-emulation/mame-libretro )
		mame2000? ( games-emulation/mame2000-libretro )
		mednafen-gba? ( games-emulation/mednafen-gba-libretro )
		mednafen-ngp? ( games-emulation/mednafen-ngp-libretro )
		mednafen-pce-fast? ( games-emulation/mednafen-pce-fast-libretro )
		mednafen-snes? ( games-emulation/mednafen-snes-libretro )
		mednafen-supergrafx? ( games-emulation/mednafen-supergrafx-libretro )
		mednafen-vb? ( games-emulation/mednafen-vb-libretro )
		mednafen-wswan? ( games-emulation/mednafen-wswan-libretro )
		meteor? ( games-emulation/meteor-libretro )
		mgba? ( || ( games-emulation/mgba-libretro games-emulation/mgba-libretro-cheevo ) )
		mupen64plus? ( games-emulation/mupen64plus-libretro )
		nestopia? ( games-emulation/nestopia-libretro )
		nxengine? ( games-emulation/nxengine-libretro )
		pcsx-rearmed? ( games-emulation/pcsx-rearmed-libretro )
		picodrive? ( games-emulation/picodrive-libretro )
		pocketsnes? ( games-emulation/pocketsnes-libretro )
		ppsspp? ( games-emulation/ppsspp-libretro )
		prboom? ( games-emulation/prboom-libretro )
		prosystem? ( games-emulation/prosystem-libretro )
		psp1? ( games-emulation/psp1-libretro )
		quicknes? ( games-emulation/quicknes-libretro )
		scummvm? ( games-emulation/scummvm-libretro )
		snes9x? ( games-emulation/snes9x-libretro )
		snes9x-next? ( games-emulation/snes9x-next-libretro )
		stella? ( games-emulation/stella-libretro )
		tgbdual? ( games-emulation/tgbdual-libretro )
		tyrquake? ( games-emulation/tyrquake-libretro )
		vba-next? ( games-emulation/vba-next-libretro )
		vbam? ( games-emulation/vbam-libretro )
		yabause? ( games-emulation/yabause-libretro )"
DEPEND=""
