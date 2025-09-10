# Friday Night Villainy V2 - A Villainous Mayhem Mobile Port
A completely original FNF Mod built on top of [FNF: Psych Engine Version 0.6.3]([https://github.com/ShadowMario/FNF-PsychEngine/releases/tag/0.6.3](https://github.com/ShadowMario/FNF-PsychEngine/tree/0.6.3)).

This was created around a month or so before release, and while it works, it has some slight issues:
- Dying can cause your game to crash. (Mostly happened on Toxic Mishap, Paycheck and Lustality, but that doesn't mean it can't happen on other songs)
- Game needs to use CopyState to copy the files, meaning the game size increases up to 4 GBS (2 GBS APK and 2 GBS Data)
- Lots of assets are made for 1280 x 720, so they could look weird. (I made my own MobileUtil class that fixes positions and all, but still)

I can't be bothered to fix this at all honestly as I've got other projects to work on.
If anyone wants to fix all the issues this has, here's the main libraries I used to get this to work:
- Lime: https://github.com/Psych-Slice/lime-mobile.git
- Hxcpp: https://github.com/Psych-Slice/hxcpp
- OpenFL: https://github.com/th2l-devs/openfl
- Extension Haptics: 1.0.3
- Extension AndroidTools: 2.2.1
- Hxvlc: https://github.com/th2l-devs/hxvlc