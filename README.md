abendbrot
===========

**Welcome to `abendbrot`,** the third-party Gentoo overlay full of:

* Old-school console emulation (e.g.,
  [RetroArch](http://www.libretro.com/index.php/retroarch-2),
  [LibRetro](http://www.libretro.com),
  [EmulationStation](http://www.emulationstation.org)).
* New-school GTK, KDE and X.org themes.

## Installation

`abendbrot` is installable in the usual way. Assuming `emerge` (and not
that *other* [disreputable fellow](http://paludis.exherbo.org)):

* Install [`layman`](https://wiki.gentoo.org/wiki/Layman), Gentoo's official
  overlay manager.

        $ emerge --ask layman
        * For <=app-portage/layman-2.2.0-r7
        $ echo 'source /var/lib/layman/make.conf' >> /etc/portage/make.conf
        * For >=app-portage/layman-2.3.0-r1[sync-plugin-portage]
        $ Nothing

* Add the `abendbrot` overlay.

        $ layman -a abendbrot

* Synchronize overlays.

        $ layman -S

## Compilation

Most ebuilds hosted at this overlay are trivially compilable. Ebuilds overwriting or updating official Portage ebuilds are keyworded and will require manual unmasking.

Some ebuilds, however, require what can only charitably be referred to as the _"Thai keyboard massage."_

### RetroArch

[RetroArch](http://www.libretro.com/index.php/retroarch-2) is the [official
frontend](http://wiki.libretro.com/index.php?title=Frontends) for
[LibRetro](http://www.libretro.com/index.php/api), a lightweight C[++] API
unifying console emulators, game engines, standalone games, media players, and
(..._wait for it_) **more** under the same umbrella interface. Each implementation
of the LibRetro API is referred to as a
[core](http://wiki.libretro.com/index.php?title=Main_Page#Core_Software_Library).
Cores exist for most popular open-source emulators (e.g.,
[Nestopia](http://wiki.libretro.com/index.php?title=Nestopia)) and game engines
(e.g., [ScummVM](http://wiki.libretro.com/index.php?title=ScummVM)) – with
(..._wait for it_) **more** continually on the way and waiting in the wings.

RetroArch and LibRetro are beasts. Let `abendbrot` tame these beasts for you:

1. **Unmask [RetroArch](http://www.libretro.com/index.php/retroarch-2),** the
   official LibRetro frontend. While [alternative
   frontends](http://wiki.libretro.com/index.php?title=Frontends) exist, you
   almost certainly want RetroArch for your first forays into LibRetro Land™.
   This overlay provides both:
   1. _(Recommended)_ **Stable RetroArch releases,**
      No unmasking required.

   1. _(Not recommended)_ The **unstable live RetroArch repository,** unmasked
      by adding the following line to `/etc/portage/package.accept_keywords`:

            ~games-emulation/retroarch-9999 **

1. **Set LibRetro core USE flags.** For each core , enable the
   [corresponding USE flag](https://github.com/stefan-gr/abendbrot/blob/master/games-emulation/libretro-meta/metadata.xml)
   provided by the `games-emulation/libretro-meta` ebuild. To
   prevent this ebuild from attempting to install other undesired LibRetro
   cores, disable all other USE flags provided by this
   ebuild. For example, to enable only the Nestopia and mGBA LibRetro cores,
   add the following line to `/etc/portage/package.use`:

        games-emulation/libretro-meta mgba nestopia -2048 -4do -beetle-psx -bnes -bsnes -desmume -dolphin -fba -fceu-next -gambatte -genplus -handy -imame4all -mame -mednafen-gba -mednafen-ngp -mednafen-pce-fast -mednafen-psx -mednafen-snes -mednafen-vb -mednafen-wswan -meteor -mupen64plus -nxengine -pcsx-rearmed -mednafen-supergrafx -picodrive -pocketsnes -ppsspp -prboom -prosystem -quicknes -scummvm -snes9x -snes9x-next -stella -tgbdual -tyrquake -vba-next -vbam -yabause

1. _(Optional)_ **Set RetroArch USE flags.** The `games-emulation/retroarch`
   ebuild provides a [variety of USE
   flags](https://github.com/stefan-gr/abendbrot/blob/master/games-emulation/retroarch/metadata.xml).
   While the defaults _should_ suffice for most use cases, the good Gentooer
   expects more. For example, to enable achievement support but disable SDL1
   support, add the following line to `/etc/portage/package.use`:

        games-emulation/retroarch cheevos -sdl

1. **Install RetroArch:**

        $ emerge --ask retroarch

1. **Live on the bleeding edge.** The stable cores provided by this overlay
    are updated quite often. But, if you want to experience retroarch completely
    on the edge then add these lines to
   `/etc/portage/package.accept_keywords`:

        games-emulation/*libretro* **
        games-emulation/retroarch **

## Issues

Please report ebuild issues, feature requests, and other pressing concerns at
our closely followed [issue
tracker](https://github.com/stefan-gr/abendbrot/issues).

Thanks, guys!

## Etymology

[Abendbrot](http://germanfood.about.com/od/breakfastanddinner/a/abendbrot.htm)
is German for "night bread," but broadly refers to the traditional evening meal
in German-speaking regions of fatty bread, fatty sliced meat, fatty cheese, and
fatty pickles. Witness the traditionally unhappy German family in its native
abendbrot environment:

![Abendbrot and the Post-modern Malaise](http://img.welt.de/img/debatte/crop105230799/0299734393-ci3x2l-w540/cl-abendbrot-DW-Politik-Bremen.jpg)

**Don't be like them.** Play RetroArch.
