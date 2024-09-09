# Friday Night Villainy V2 - A Villainous Mayhem
A completely original FNF Mod built on top of [FNF: Psych Engine Version 0.6.3]([https://github.com/ShadowMario/FNF-PsychEngine/releases/tag/0.6.3](https://github.com/ShadowMario/FNF-PsychEngine/tree/0.6.3)).

!**** !!IMPORTANT! : This specific engine version has been completely modified, adding in new features and enhancements!! ****

![](art/promoart.png)

_____________________________________
### Documenation
- [Compiling the game](#compilation-instructions)
- [New content](#new-content)
- [Debug features](#debug-features)

_____________________________________
## Compilation Instructions:
Psych Engine insists (rightfully) that you must have [the most up-to-date version of Haxe](https://haxe.org/download/).
For this mod specifically, it was made using [Haxe 4.2.5](https://haxe.org/download/version/4.2.5/), so it is mostly recommended you use that. Newer versions will probably work, not too sure though, I'm not going into this much detail whatsoever.

Now as regards the libraries you need to use to be able to compile the mod properly, these are the ones the mod uses:
- actuate: [1.9.0]
- box2d: [1.2.3]
- discord_rpc: [git]
- faxe: [git]
- flixel-addons: [2.11.0]
- flixel-demos: [3.0.0]
- flixel-templates: [2.6.6]
- flixel-tools: [1.5.1]
- flixel-ui: [2.4.0]
- flixel: [4.11.0]
- haxelib: [4.1.0]
- hmm: [3.1.0]
- hscript: [2.4.0]
- hxCodec: [2.5.1]
- hxcpp: [4.2.1]
- hxvm-luajit: [git]
- layout: [1.2.1]
- lime-samples: [7.0.0]
- lime: [7.9.0]
- linc_luajit: [git] -> !!To install LuaJIT, put this on CMD: `haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit`!!
- newgrounds: [2.0.2]
- openfl-samples: [8.7.0]
- openfl: [9.1.0]
- polymod: [git]
- seedyrng: [1.1.0]
- systools: [1.1.0]
- thx.core: [0.44.0]
- thx.semver: [0.2.2]
- utest: [1.13.2]

Once you have the libraries installed and the files ready, there's a few more things you should do. [ONLY FOR THE FIRST TIME YOU EVER COMPILE THE MOD]:
- Download [Finale_Intro.mp4](https://drive.google.com/file/d/12ZAM_q8kHkL2tgiyjqrJmk6AXHECX8Lw/view?usp=sharing).
- Add it inside the mods folder that's in the source code.
- Compile the game. Once it's ready, immediately close the game as you don't have everything ready yet.
- Copy and paste the "Mods" folder in your exported game.
- Enjoy!
_____________________________________
## New Content

To be added.

_____________________________________
## Debug Features

To enable debugging features of the mod add this line of code inside [Project.xml]: `<define name="DEBUG_ALLOWED"/> `

With it, you get:
- Access to the Master Editor Menu (Including ALL editors)
- Access to Chart Editor in PlayState
- Ability to 100% completing the game (Press V in Title Screen)
- Ability to hide ingame Discord Status