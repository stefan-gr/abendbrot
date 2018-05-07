# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Meta package for various libretro implementations"
HOMEPAGE="http://www.libretro.com/"
LICENSE="metapackage"
SLOT="0"
IUSE="+2048 +4do +beetle-psx bnes +bsnes bsnes-cpp98 citra craft +desmume dolphin easyrpg +fbalpha fbalpha2012 fceumm +gambatte +genplus \
+handy mame mame2000 +mame2003 mame2016 mednafen-gba +mednafen-ngp +mednafen-pce-fast \
+mednafen-saturn mednafen-snes +mednafen-vb +mednafen-wswan melonds meteor meowpc98 +mgba mrboom +mupen64plus +nestopia +nxengine \
openlara pcsx-rearmed +mednafen-supergrafx parallel-n64 picodrive +ppsspp +prboom +prosystem px68k quicknes redream +reicast sameboy +scummvm \
snes9x snes9x2002 snes9x2010 +stella tgbdual +tyrquake vba-next vbam yabause"

KEYWORDS="amd64 x86 arm"

RDEPEND="2048? ( games-emulation/2048-libretro )
		4do? ( games-emulation/4do-libretro )
		beetle-psx? ( games-emulation/beetle-psx-libretro )
		bnes? ( games-emulation/bnes-libretro )
		bsnes-cpp98? ( games-emulation/bsnes-libretro-cplusplus98 )
		bsnes? ( games-emulation/bsnes-libretro )
		citra? ( games-emulation/citra-libretro )
		craft? ( games-emulation/craft-libretro )
		desmume? ( games-emulation/desmume-libretro )
		dolphin? ( games-emulation/dolphin-libretro )
		easyrpg? ( games-emulation/easyrpg-libretro )
		fbalpha? ( games-emulation/fbalpha-libretro )
		fbalpha2012? ( games-emulation/fbalpha2012-libretro )
		fceumm? ( || ( games-emulation/fceumm-libretro games-emulation/fceu-next-libretro ) )
		gambatte? ( games-emulation/gambatte-libretro )
		genplus? ( games-emulation/genplus-libretro )
		handy? ( games-emulation/handy-libretro )
		mame2000? ( games-emulation/mame2000-libretro )
		mame2003? ( games-emulation/mame2003-libretro )
		mame2016? ( games-emulation/mame2016-libretro )
		mame? ( games-emulation/mame-libretro )
		mednafen-gba? ( games-emulation/mednafen-gba-libretro )
		mednafen-ngp? ( games-emulation/mednafen-ngp-libretro )
		mednafen-pce-fast? ( games-emulation/mednafen-pce-fast-libretro )
		mednafen-saturn? ( games-emulation/mednafen-saturn-libretro )
		mednafen-snes? ( games-emulation/mednafen-snes-libretro )
		mednafen-supergrafx? ( games-emulation/mednafen-supergrafx-libretro )
		mednafen-vb? ( games-emulation/mednafen-vb-libretro )
		mednafen-wswan? ( games-emulation/mednafen-wswan-libretro )
		melonds? ( games-emulation/melonds-libretro )
		meowpc98? ( games-emulation/meowpc98-libretro )
		meteor? ( games-emulation/meteor-libretro )
		mgba? ( || ( games-emulation/mgba-libretro games-emulation/mgba-libretro-cheevo ) )
		mrboom? ( games-emulation/mrboom-libretro )
		mupen64plus? ( games-emulation/mupen64plus-libretro )
		nestopia? ( games-emulation/nestopia-libretro )
		nxengine? ( games-emulation/nxengine-libretro )
		openlara? ( games-emulation/openlara-libretro )
		parallel-n64? ( games-emulation/parallel-n64-libretro )
		pcsx-rearmed? ( games-emulation/pcsx-rearmed-libretro )
		picodrive? ( games-emulation/picodrive-libretro )
		ppsspp? ( games-emulation/ppsspp-libretro )
		prboom? ( games-emulation/prboom-libretro )
		prosystem? ( games-emulation/prosystem-libretro )
		px68k? ( games-emulation/px68k-libretro )
		quicknes? ( games-emulation/quicknes-libretro )
		redream? ( games-emulation/redream-libretro )
		reicast? ( games-emulation/reicast-libretro )
		sameboy? ( games-emulation/sameboy-libretro )
		scummvm? ( games-emulation/scummvm-libretro )
		snes9x2002? ( games-emulation/snes9x2002-libretro )
		snes9x2010? ( games-emulation/snes9x2010-libretro )
		snes9x? ( games-emulation/snes9x-libretro )
		stella? ( games-emulation/stella-libretro )
		tgbdual? ( games-emulation/tgbdual-libretro )
		tyrquake? ( games-emulation/tyrquake-libretro )
		vba-next? ( games-emulation/vba-next-libretro )
		vbam? ( games-emulation/vbam-libretro )
		yabause? ( games-emulation/yabause-libretro )"
DEPEND=""
