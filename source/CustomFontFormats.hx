package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CustomFontFormats {
    //Custom Text Formats
    //Text color, bold, italic, border color, underline
    public static var redBold = new FlxTextFormat(0xFF0000, true, true, null, false);
    public static var redBoldUnderline = new FlxTextFormat(0xFF0000, true, true, null, true);
    public static var redSimple = new FlxTextFormat(0xFF0000, false, false, null, false);

    public static var darkRedBold = new FlxTextFormat(0x610000, true, true, null, false);
    public static var darkRedBoldUnderline = new FlxTextFormat(0x610000, true, true, null, true);
    public static var darkRedSimple = new FlxTextFormat(0x610000, false, false, null, false);

    public static var goldHighlight = new FlxTextFormat(0xFFD700, true, false, null, false);

    public static var yellowBold = new FlxTextFormat(0xFFD700, true, false, null, false);
    public static var yellowBoldUnderline = new FlxTextFormat(0xFFD700, true, false, null, true);
    public static var yellowSimple = new FlxTextFormat(0xFFD700, true, false, null, false);

    public static var greenBold = new FlxTextFormat(0x00ff15, true, false, null, false);
    public static var greenBoldUnderline = new FlxTextFormat(0x00ff15, true, false, null, true);
    public static var greenSimple = new FlxTextFormat(0x00ff15, false, false, null, false);

    public static var blueBold = new FlxTextFormat(0x0000ff, true, false, null, false);
    public static var blueBoldUnderline = new FlxTextFormat(0x0000ff, true, false, null, true);
    public static var blueSimple = new FlxTextFormat(0x0000ff, false, false, null, false);

    public static var cyanBold = new FlxTextFormat(0x03f4fc, true, false, null, false);
    public static var cyanBoldUnderline = new FlxTextFormat(0x03f4fc, true, false, null, true);
    public static var cyanSimple = new FlxTextFormat(0x03f4fc, false, false, null, false);

    public static var darkPinkBold = new FlxTextFormat(0x960094, true, true, null, false);
    public static var darkPinkBoldUnderline = new FlxTextFormat(0x960094, true, true, null, true);
    public static var darkPinkSimple = new FlxTextFormat(0x960094, false, false, null, false);

    public static var pinkBold = new FlxTextFormat(0xff45f9, true, true, null, false);
    public static var pinkBoldUnderline = new FlxTextFormat(0xff45f9, true, true, null, true);
    public static var pinkSimple = new FlxTextFormat(0xff45f9, false, false, null, false);

    //Custom Marks
    public static var redFormatBold = new FlxTextFormatMarkerPair(redBold, "<R>");
    public static var redFormatBoldUnderline = new FlxTextFormatMarkerPair(redBoldUnderline, "<R_>");
    public static var redFormatSimple = new FlxTextFormatMarkerPair(redSimple, "<r>");

    public static var darkRedFormatBold = new FlxTextFormatMarkerPair(darkRedBold, "<DR>");
    public static var darkRedFormatBoldUnderline = new FlxTextFormatMarkerPair(darkRedBoldUnderline, "<DR_>");
    public static var darkRedFormatSimple = new FlxTextFormatMarkerPair(darkRedSimple, "<dr>");

    public static var goldFormatHighlight = new FlxTextFormatMarkerPair(goldHighlight, "<G>");

    public static var yellowFormatBold = new FlxTextFormatMarkerPair(yellowBold, "<Y>");
    public static var yellowFormatBoldUnderline = new FlxTextFormatMarkerPair(yellowBoldUnderline, "<Y_>");
    public static var yellowFormatSimple = new FlxTextFormatMarkerPair(yellowSimple, "<y>");

    public static var greenFormatBold = new FlxTextFormatMarkerPair(greenBold, "<GR>");
    public static var greenFormatBoldUnderline = new FlxTextFormatMarkerPair(greenBoldUnderline, "<GR_>");
    public static var greenFormatSimple = new FlxTextFormatMarkerPair(greenSimple, "<gr>");

    public static var blueFormatBold = new FlxTextFormatMarkerPair(blueBold, "<B>");
    public static var blueFormatBoldUnderline = new FlxTextFormatMarkerPair(blueBoldUnderline, "<B_>");
    public static var blueFormatSimple = new FlxTextFormatMarkerPair(blueSimple, "<b>");

    public static var cyanFormatBold = new FlxTextFormatMarkerPair(cyanBold, "<C>");
    public static var cyanFormatBoldUnderline = new FlxTextFormatMarkerPair(cyanBoldUnderline, "<C_>");
    public static var cyanFormatSimple = new FlxTextFormatMarkerPair(cyanSimple, "<c>");

    public static var darkPinkFormatBold = new FlxTextFormatMarkerPair(darkPinkBold, "<DP>");
    public static var darkPinkFormatBoldUnderline = new FlxTextFormatMarkerPair(darkPinkBoldUnderline, "<DP_>");
    public static var darkPinkFormatSimple = new FlxTextFormatMarkerPair(darkPinkSimple, "<dp>");

    public static var pinkFormatBold = new FlxTextFormatMarkerPair(pinkBold, "<P>");
    public static var pinkFormatBoldUnderline = new FlxTextFormatMarkerPair(pinkBoldUnderline, "<P_>");
    public static var pinkFormatSimple = new FlxTextFormatMarkerPair(pinkSimple, "<p>");

    public static function addMarkers(text:FlxText)
    {
        text.applyMarkup(text.text, [
            redFormatBold,
            redFormatBoldUnderline,
            redFormatSimple,

            darkRedFormatBold,
            darkRedFormatBoldUnderline,
            darkRedFormatSimple,

            goldFormatHighlight,

            yellowFormatBold,
            yellowFormatBoldUnderline,
            yellowFormatSimple,

            greenFormatBold,
            greenFormatBoldUnderline,
            greenFormatSimple,

            blueFormatBold,
            blueFormatBoldUnderline,
            blueFormatSimple,

            cyanFormatBold,
            cyanFormatBoldUnderline,
            cyanFormatSimple,

            darkPinkFormatBold,
            darkPinkFormatBoldUnderline,
            darkPinkFormatSimple,

            pinkFormatBold,
            pinkFormatBoldUnderline,
            pinkFormatSimple
        ]);
    }
}