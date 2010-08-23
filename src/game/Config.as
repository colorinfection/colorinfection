package game {


   public class Config {
      
      
      
      public static const kForDebug:Boolean = false;
      public static const kSupportTimeScale:Boolean = true;
      
      public static const kGameName_1:String = "Color Infection 2";
      public static const kGameName_2:String = "Color Infection 2";
      public static var kGameName:String = kGameName_2;
      public static const kVersionString:String = "1.0";
      public static const kGameDataName:String = "ColorInfection_2_0";
      
      public static const kSponsorName:String = "FlashPhysicsGames.com ";
      public static const kSponsorLink:String = "http://www.FlashPhysicsGames.com";
      
      public static const InfectedColor:uint = 0x804000;
      public static const InfectedColorsHtmlString:String = "#804000";
      
      public static const NotInfectedColor:uint = 0xFFFF00;
      public static const NotInfectedColorHtmlString:String = "#FFFF00";
      
      public static const DontInfectColor:uint = 0x60FF60;
      public static const DontInfectColorHtmlString:String = "#60FF60";
      
      public static const BreakableColor:uint = 0xFF00FF;
      public static const BreakableColorHtmlString:String = "#FF00FF";
      public static const NotBreakableColor:uint = 0x0000FF;
      
      public static const StaticObjectColor:uint = 0xFF606060;
      public static const MovingObjectColor:uint = 0xFFA0A0FF;
      
      
      public static const kHelpDialogText1:String = 
                           "<font face=\"Verdana\" SIZE=\"12\">The goal of the game is to infect all <font color=\"" + NotInfectedColorHtmlString + "\"><b>YELLOW</b></font> balls with"
                     + "<br>the <font color=\"" + InfectedColorsHtmlString + "\"><b>BROWN</b></font> color by colliding them with <font color=\"" + InfectedColorsHtmlString + "\"><b>BROWN</b></font> balls"
                     + "<br>but keep <font color=\"" + DontInfectColorHtmlString + "\"><b>GREEN</b></font> balls uninfected.</font>";
                     
      public static const kHelpDialogText2:String = 
                           "<FONT face=\"Verdana\" SIZE=\"14\">The goal of the game is to infect all <font color=\"" + NotInfectedColorHtmlString + "\"><b>YELLOW</b></font> balls with"
                     + "<br>the <font color=\"" + InfectedColorsHtmlString + "\"><b>BROWN</b></font> color by colliding them with <font color=\"" + InfectedColorsHtmlString + "\"><b>BROWN</b></font> balls."
                     + "<br><b>Notices</b>: DON'T infect <font color=\"" + DontInfectColorHtmlString + "\"><b>GREEN</b></font> balls."
                     + "<br>To play, left click a <font color=\"" + BreakableColorHtmlString + "\"><b>PINK</b></font> object to destroy it.</font>";
                     
                     
      public static const kHelpDialogText:String = kHelpDialogText1
                     + "<font face=\"Verdana\" SIZE=\"12\"><br><br><b>Control:</b>"
                     + "<br> - left click a <font color=\"" + BreakableColorHtmlString + "\"><b>PINK</b></font> object to release a ball."
                     + "<br> - select <b>Restart</b> menu or press <b>R</b> to restart current level."
                     + "<br> - press <b>B</b> to toggle <b>Color Blind Mode</b>."
                     + "<br> - press 0-9 to set time scale as the corresponding value. (As"
                     + "<br>   red wine, the beauty of physics needs to be enjoyed slowly.)"
                     + "<br> - press ~ or NUMPAD / to set time scale as 0.5 (slow motion)."
                     + "<br><br><P ALIGN=\"CENTER\">(Click <b>Help</b> menu again to close this dialog.)</P></font>";
      
      public static const kTutorialTexts:Array = [
      ];
      
      public static const kTitleText_1:String = 
         "<FONT FACE=\"Verdana\" SIZE=\"39\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>" + kGameName_1 + "</b></FONT>";
      public static const kTitleText_2:String = 
         "<FONT FACE=\"Verdana\" SIZE=\"39\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>" + kGameName_2 + "</b></FONT>";
      public static var kTitleText:String = kTitleText_2;
      
      
      public static const kGameFinishedText:String = 
         "<P ALIGN=\"CENTER\"><FONT FACE=\"Verdana\" SIZE=\"20\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Congratulation!</b></FONT></P>"
         + "<br>All levels are finished. Cool! You know, it is not an easy job"
         + "<br>to finish all the levels. Only the most intelligent people can"
         + "<br>do this. If you like this game, please recommend it to your"
         + "<br>friends. Let more people challenge the impossible missions! :)";
      
      public static const kLevelFinishedText:String = 
         "<FONT FACE=\"Verdana\" SIZE=\"50\" COLOR=\"#0000FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Level Finished</b></FONT>";
      
      public static const kMainMenuButtonTextWithBr:String = 
         "<P ALIGN=\"CENTER\"><FONT FACE=\"Verdana\" SIZE=\"39\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Main<BR>Menu</b></FONT></P>";
      
      public static const kTapirGamesButtonText:String = 
         "<P ALIGN=\"CENTER\"><FONT FACE=\"Verdana\" SIZE=\"39\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Tapir Games</b></FONT></P>";
      
      public static const kTapirGamesButtonTextWithBr:String = 
         "<P ALIGN=\"CENTER\"><FONT FACE=\"Verdana\" SIZE=\"39\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Tapir<BR>Games</b></FONT></P>";
      
      public static const kExtraLevelsButtonText:String = 
         "<P ALIGN=\"CENTER\"><FONT FACE=\"Verdana\" SIZE=\"12\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Play 5 Extra Levels</b></FONT></P>";
      
      
      
      public static const kLevelDifficuties:Array = [
          1, 1, 1, 1, 1, 1, 1, 1, 1, 1, // 1 - 10
          1, 1, 1, 1, 1, 1, 1, 1, 1, 1, // 11 - 20
          1, 1, 1, 1, 1, 1, 1, 1, 1, 1, // 21 - 30
      ];
      

      
      public function Config ()
      {
      }
      
   }
   
}