package;

class CustomFontFormats {
    //Custom Text Formats
    //Text color, bold, italic, border color, underline
    public static var redBold = new FlxTextFormat(0xFF0000, true, true, null);
    public static var redSimple = new FlxTextFormat(0xFF0000, false, false, null);

    public static var darkRedBold = new FlxTextFormat(0x610000, true, true, null);
    public static var darkRedSimple = new FlxTextFormat(0x610000, false, false, null);

    public static var goldHighlight = new FlxTextFormat(0xFFD700, true, false, null);

    public static var whiteHighlight = new FlxTextFormat(0xFFFFFF, true, false, null);

    public static var yellowBold = new FlxTextFormat(0xFFD700, true, false, null);
    public static var yellowSimple = new FlxTextFormat(0xFFD700, true, false, null);

    public static var greenBold = new FlxTextFormat(0x00ff15, true, false, null);
    public static var greenSimple = new FlxTextFormat(0x00ff15, false, false, null);

    public static var darkGreenBold = new FlxTextFormat(0x027d02, true, false, null);
    public static var darkGreenSimple = new FlxTextFormat(0x027d02, false, false, null);

    public static var blueBold = new FlxTextFormat(0x0000ff, true, false, null);
    public static var blueSimple = new FlxTextFormat(0x0000ff, false, false, null);

    public static var cyanBold = new FlxTextFormat(0x03f4fc, true, false, null);
    public static var cyanSimple = new FlxTextFormat(0x03f4fc, false, false, null);

    public static var darkPinkBold = new FlxTextFormat(0x960094, true, true, null);
    public static var darkPinkSimple = new FlxTextFormat(0x960094, false, false, null);

    public static var pinkBold = new FlxTextFormat(0xff45f9, true, true, null);
    public static var pinkSimple = new FlxTextFormat(0xff45f9, false, false, null);

    public static var purpleBold = new FlxTextFormat(0x8400ff, true, true, null);
    public static var purpleSimple = new FlxTextFormat(0x8400ff, false, false, null);

    //Custom Marks
    public static var redFormatBold = new FlxTextFormatMarkerPair(redBold, "<R>");
    public static var redFormatSimple = new FlxTextFormatMarkerPair(redSimple, "<r>");

    public static var darkRedFormatBold = new FlxTextFormatMarkerPair(darkRedBold, "<DR>");
    public static var darkRedFormatSimple = new FlxTextFormatMarkerPair(darkRedSimple, "<dr>");

    public static var goldFormatHighlight = new FlxTextFormatMarkerPair(goldHighlight, "<G>");

    public static var whiteFormatHighlight = new FlxTextFormatMarkerPair(whiteHighlight, "<W>");

    public static var yellowFormatBold = new FlxTextFormatMarkerPair(yellowBold, "<Y>");
    public static var yellowFormatSimple = new FlxTextFormatMarkerPair(yellowSimple, "<y>");

    public static var greenFormatBold = new FlxTextFormatMarkerPair(greenBold, "<GR>");
    public static var greenFormatSimple = new FlxTextFormatMarkerPair(greenSimple, "<gr>");

    public static var darkGreenFormatBold = new FlxTextFormatMarkerPair(darkGreenBold, "<DGR>");
    public static var darkGreenFormatSimple = new FlxTextFormatMarkerPair(darkGreenSimple, "<dgr>");

    public static var blueFormatBold = new FlxTextFormatMarkerPair(blueBold, "<B>");
    public static var blueFormatSimple = new FlxTextFormatMarkerPair(blueSimple, "<b>");

    public static var cyanFormatBold = new FlxTextFormatMarkerPair(cyanBold, "<C>");
    public static var cyanFormatSimple = new FlxTextFormatMarkerPair(cyanSimple, "<c>");

    public static var darkPinkFormatBold = new FlxTextFormatMarkerPair(darkPinkBold, "<DP>");
    public static var darkPinkFormatSimple = new FlxTextFormatMarkerPair(darkPinkSimple, "<dp>");

    public static var pinkFormatBold = new FlxTextFormatMarkerPair(pinkBold, "<P>");
    public static var pinkFormatSimple = new FlxTextFormatMarkerPair(pinkSimple, "<p>");

    public static var purpleFormatBold = new FlxTextFormatMarkerPair(purpleBold, "<PUR>");
    public static var purpleFormatSimple = new FlxTextFormatMarkerPair(purpleSimple, "<pur>");

    public static function addMarkers(text:FlxText)
    {
        text.applyMarkup(text.text, [
            redFormatBold,
            redFormatSimple,

            darkRedFormatBold,
            darkRedFormatSimple,

            goldFormatHighlight,
            whiteFormatHighlight,

            yellowFormatBold,
            yellowFormatSimple,

            greenFormatBold,
            greenFormatSimple,

            darkGreenFormatBold,
            darkGreenFormatSimple,

            blueFormatBold,
            blueFormatSimple,

            cyanFormatBold,
            cyanFormatSimple,

            darkPinkFormatBold,
            darkPinkFormatSimple,

            pinkFormatBold,
            pinkFormatSimple,
            
            purpleFormatBold,
            purpleFormatSimple
        ]);
    }
}