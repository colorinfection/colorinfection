package game.state {
   
   import flash.display.Shape;
   import flash.events.MouseEvent;
   
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   
   import engine.Engine;
   import engine.util.Util;
   
   import game.GameState;
   
   import game.Game;
   
   import game.ResLoader;
   
   import game.display.DialogBox;
   import game.display.HtmlTextButton;
   
   import game.OnlineAPI;
   
   import game.Config;
   import game.DomainStrategy;
   
   
   public class GameState_Startup extends GameState {
      
      private var mBlackBackground:Shape;
      private var mWaitText:DialogBox;
      private var mBox2DCreditText:DialogBox;
      private var mSponsorCreditText:DialogBox;
      private var mPlayButton:HtmlTextButton;
      private var mPlayOnKongregateButton:HtmlTextButton;
      
      public function GameState_Startup (game:Game)
      {
         super (game);
      }
      
      override public function Initialize ():void
      {
         
         DomainStrategy.Initialize (Engine.GetTopObjectUrl ());
         
         //
         mBlackBackground = new Shape();
         mBlackBackground.graphics.beginFill(0x0);
         mBlackBackground.graphics.lineStyle(0, 0x0);
         mBlackBackground.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height);
         mBlackBackground.graphics.endFill();
         mGame.addChild(mBlackBackground);
         
         
         
         //
         mWaitText = new DialogBox ();
         mGame.addChild (mWaitText);
         
         mWaitText.SetText ("Initializing ...", true);
         mWaitText.SetCached (false);
         mWaitText.SetBackgroundVisible (false);
         mWaitText.SetTextColor (0xFFFF00);
         
         mWaitText.Rebuild ();
         
         mWaitText.x = (App::Default_Width - mWaitText.width)/ 2;
         mWaitText.y = (App::Default_Height - mWaitText.height) / 2;
         
         //
         mPlayButton = new HtmlTextButton ("<FONT FACE=\"Times New Roman\" SIZE=\"39\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Play</b></FONT>"
                                             , true, true);
         mPlayButton.addEventListener( MouseEvent.CLICK, OnClickPlayButton );
         mPlayButton.x = (App::Default_Width - mPlayButton.width)/ 2;
         mPlayButton.y = App::Default_Height * 2 / 5 - mPlayButton.height / 2;
         mPlayButton.visible = false;
         mGame.addChild (mPlayButton);
         
         //
         
         mPlayOnKongregateButton = new HtmlTextButton ("<FONT FACE=\"Times New Roman\" SIZE=\"30\" COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Please Play This Game on Kongregate</b></FONT>"
                                             , true, true);
         mPlayOnKongregateButton.addEventListener( MouseEvent.CLICK, OnClickPlayOnKongregateButton );
         mPlayOnKongregateButton.x = (App::Default_Width - mPlayOnKongregateButton.width)/ 2;
         mPlayOnKongregateButton.y = App::Default_Height * 2 / 5 - mPlayOnKongregateButton.height / 2;
         mPlayOnKongregateButton.visible = false;
         mGame.addChild (mPlayOnKongregateButton);

         
         //
         var startupScreenString:String = "<font face=\"Verdana\" size=\"12\">" + Config.kGameName + " - a game based on Box2d (AS3) Physics Engine" + "</font>";
         
         // sponsor 
         if (DomainStrategy.sShowSponsorOnStartupScreen)
         {
            startupScreenString = startupScreenString + ", <br/><font size=\"12\">" + "and sponsored by " + Config.kSponsorName + "</font>";
         }
         
         startupScreenString = "<p align=\"center\">" + startupScreenString + "</p>";
         
         mBox2DCreditText = new DialogBox ();
         mGame.addChild (mBox2DCreditText);
         
         mBox2DCreditText.SetText (startupScreenString, true);
         mBox2DCreditText.SetCached (false);
         mBox2DCreditText.SetBackgroundVisible (false);
         mBox2DCreditText.SetTextColor (0xFFFF00);
         
         mBox2DCreditText.Rebuild ();
         
         mBox2DCreditText.x = (App::Default_Width - mBox2DCreditText.width) / 2;
         mBox2DCreditText.y = App::Default_Height * 5 / 6 - mBox2DCreditText.height / 2;
         
      }
      
      public function OnClickPlayButton (event:MouseEvent):void
      {
         mGame.SetNextGameStateID (Game.k_GameState_MainMenu);
         
         Game.LoadGame ();
         
         trace ("SetNextGameStateID (Game.k_GameState_MainMenu)");
      }
      
      public function OnClickPlayOnKongregateButton(event:MouseEvent):void
      {
         var url:String = "http://www.kongregate.com/games/tapir/pdecathlon-the-hardest-physics-game";
         var request:URLRequest = new URLRequest(url);
         try {            
             navigateToURL(request, "_top");
         }
         catch (e:Error) {
             trace ("navigateToURL error.");
         }
      }
      
      override public function Destroy ():void
      {
         mGame.removeChild (mWaitText);
         mGame.removeChild (mPlayButton);
         mGame.removeChild (mBox2DCreditText);
         if (mSponsorCreditText != null)
            mGame.removeChild (mSponsorCreditText);
      }
      
      private var mOldInitializedValue:Boolean = false;
      override public function Update (escapedTime:Number):void
      {
         if (ResLoader.mInitialized && ! mOldInitializedValue)
         {
            mOldInitializedValue = true;
            
            //
            mWaitText.visible = false;
            
            //
            if (DomainStrategy.sIsDomainValid)
               mPlayButton.visible = true;
            else
               mPlayOnKongregateButton.visible = true;
         }
      }
      

      

      

   }
}