package game.state {

   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   import flash.display.Shape;
   
   import flash.utils.ByteArray;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import flash.events.MouseEvent;
   
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   import flash.ui.Mouse;
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Sprite2dModelInstance;
   
   
   import game.GameState;
   import game.GameEntity;
   
   import game.level.Level;
   
   import game.Game;
   
   import game.Config;
   
   import game.general.SoundPlayer;
   
   import game.display.DialogBox;
   import game.display.HtmlTextButton;
   import game.display.ImageButton;
   
   import game.general.SoundPlayer;
   
   import game.AdManager;
   import game.DomainStrategy;
   import game.OnlineAPI;
   
   public class GameState_Level extends GameState 
   {
      private static var sLevelFinishedSprite:DialogBox;
      private static var sGameFinishedSprite:DialogBox;
      
      private static var sHelpDialog:DialogBox;
      private static var sSoundButton:SimpleButton;
      
      
      private static const AnimID_SoundOn:int = 4;
      private static const AnimID_SoundOff:int = 5;
      
      private var mEntityContainer:Sprite;
      private static var mBackground:Shape;
      private static var mBackground2:Shape;
      
      private var mLevel:Level;
      
      private var mTopBlackBar:Shape;
      private var mBottomBlackBar:Shape;
      private var mBlackBarMinHeight:uint = 23;
      
      private var mExitMenu:TextField;
      private var mHelpMenu:TextField;
      
      private var mRestartMenu:TextField;
      private var mUndoMenu:TextField;
      
      //private var mSoundMenu:TextField;
      
      //////////////////////////
      
      
      //////////////////////////
      private var mInfoText:TextField;
      
      private var mFlipSteps:uint = 0;
      
      
      
      public static var sNeedRestart:Boolean;
      public static var sNeedUndo:Boolean;
      
      public function GameState_Level (game:Game)
      {
         super (game);
      }
      
      
      override public function Initialize ():void
      {
         //
         if (mBackground == null)
         {
            mBackground = new Shape();
            mBackground.graphics.beginFill(Config.StaticObjectColor);
            mBackground.graphics.lineStyle(0, 0xDDDDA0);
            mBackground.graphics.drawRect(0, 0, App::Default_Width + 100, App::Default_Height + 100);
            mBackground.graphics.endFill();
         }         
         mBackground.x = -50;
         mBackground.y = -50;
         mGame.addChild (mBackground);
         
         if (mBackground2 == null)
         {
            mBackground2 = new Shape();
            mBackground2.graphics.beginFill(0xAAAA80);
            mBackground2.graphics.lineStyle(0, 0xDDDDA0);
            mBackground2.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height);
            mBackground2.graphics.endFill();
         }
         mBackground2.x = 0;
         mBackground2.y = 0;
         mGame.addChild (mBackground2);
         
         
         
         //
         mEntityContainer = new Sprite ();
         mGame.addChild (mEntityContainer);
         
         //
         LoadCurrentLevel ();
         
         //
         AddGameFinishedSprite ();
         AddHelpDialog ();
         AddLevelFinishedSprite ();
     //    AddSoundButton ();
         //AddHtmlTextButtons ();
         
         //
         mTopBlackBar = new Shape();
         mTopBlackBar.graphics.beginFill(0x0);
         mTopBlackBar.graphics.lineStyle(0, 0x0);
         mTopBlackBar.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height / 2);
         mTopBlackBar.graphics.endFill();
         
         mEntityContainer.addChild(mTopBlackBar);
         
         mBottomBlackBar = new Shape();
         mBottomBlackBar.graphics.beginFill(0x0);
         mBottomBlackBar.graphics.lineStyle(0, 0x0);
         mBottomBlackBar.graphics.drawRect(0, - App::Default_Height / 2, App::Default_Width, App::Default_Height / 2);
         mBottomBlackBar.graphics.endFill();
         mBottomBlackBar.y = App::Default_Height;
         
         mEntityContainer.addChild(mBottomBlackBar);
         
         //
         mExitMenu = CreateMenuText (" Menu ", true);
         mExitMenu.x = 3;
         mExitMenu.y = 1;
         
         mHelpMenu = CreateMenuText (" Help ", true);
         mHelpMenu.x = mExitMenu.x + mExitMenu.width + 10;
         mHelpMenu.y = 1;
         
         mRestartMenu = CreateMenuText (" Restart ", true);
         mRestartMenu.x = mTopBlackBar.width - mRestartMenu.width - 3;
         mRestartMenu.y = 1;
         
         mUndoMenu = CreateMenuText (" Undo ", true);
         mUndoMenu.x = mRestartMenu.x - mUndoMenu.width - 3;
         mUndoMenu.y = 1; 
         
         //mSoundMenu = CreateMenuText (SoundPlayer.IsSoundOn () ? " Sound Off " :" Sound On ", true);
         //mSoundMenu.x = mRestartMenu.x + mRestartMenu.width + 10;
         //mSoundMenu.y = 1;
         
         mInfoText = CreateMenuText ("", false);
         UpdateInfoText (1);
         mInfoText.x = (App::Default_Width - mInfoText.width) / 2;
         mInfoText.y = 1;
         mInfoText.visible = Config.kSupportTimeScale;
         
         ChangeState ( State_OpenScreen );
         
         PlayBackgroundSound ();
      }
      
      override public function Destroy ():void
      {
         mGame.removeChild (mEntityContainer);
         mGame.removeChild (mBackground);
         mGame.removeChild (mBackground2);
      }
      
      
      
      private function LoadCurrentLevel ():void
      {
         if (mLevel != null)
         {
            mLevel.Destroy ();
            mEntityContainer.removeChild (mLevel);
         }
      
         mLevel = new Level ();
         
         //mLevel.scaleX = 0.5;
         //mLevel.scaleY = 0.5;
         
         var levelFile:String = Game.sLevelFilePaths [ Game.sCurrentLevelIndex ] as String;
         var levelData:ByteArray = Engine.GetDataAsset (levelFile) as ByteArray;
         levelData.position = 0;
         mLevel.Load (levelFile, levelData);
         
         mEntityContainer.addChildAt (mLevel, 0);
         
         mLevel.Initialize ();
         
         // 
         
         mLevel.x = (App::Default_Width  - mLevel.GetPlayfieldWidth ()  ) / 2;
         mLevel.y = (App::Default_Height - mLevel.GetPlayfieldHeight () ) / 2;
         
         sNeedRestart = false;
         sNeedUndo = false;
         
         //
         Mouse.show ();
      }
      
      
//=====================================================================================
      
      private function AddOtherEntities ():void
      {
         mEntityContainer.addChild (mExitMenu);
         mEntityContainer.addChild (mHelpMenu);
         mEntityContainer.addChild (mRestartMenu);
    //     mEntityContainer.addChild (mUndoMenu);
         
    //     mEntityContainer.addChild (sSoundButton);
         
         mEntityContainer.addChild (mInfoText);
         
         ShowTextLinks ();
      }
      
      private function CreateMenuText (label:String, needEventHandlers:Boolean):TextField
      {
         var menu:TextField = new TextField ();
         
         menu.autoSize = TextFieldAutoSize.LEFT;
         menu.selectable = false;
         menu.background = false;
         //menu.backgroundColor = 0xA0A0FF;
         menu.textColor = 0xFFFF00;
         menu.htmlText = "<FONT face=\"Verdana\" SIZE=\"12\">" + label + "</font>";
         
         if (needEventHandlers)
         {
            menu.addEventListener( MouseEvent.CLICK, OnMenuClick );
            menu.addEventListener( MouseEvent.MOUSE_OVER, OnMenuMouseOver );
            menu.addEventListener( MouseEvent.MOUSE_OUT, OnMenuMouseOut );
         }
         
         //if (menu.height > mBlackBarMinHeight - 2)
         //   mBlackBarMinHeight = menu.height + 2;
         
         return menu;
      }
      
      private var _lastTimeScale:Number = -1;
      private function UpdateInfoText (timeScale:Number):void
      {
         if (_lastTimeScale != timeScale)
            mInfoText.htmlText = "<FONT face=\"Verdana\" SIZE=\"12\">" + "     Time Scale: " + timeScale + "</font>";
         _lastTimeScale = timeScale;
      }
      
      private function OnMenuClick( event:MouseEvent ):void 
      {
         var menu:TextField = (event.target as TextField);
         if (menu == mExitMenu)
         {
            GoToMainMenu ();
         }
         else if (menu == mHelpMenu)
         {
            sHelpDialog.visible = ! sHelpDialog.visible;
         }
         //else if (menu == mSoundMenu)
         //{
         //   SoundPlayer.SwitchSoundOnOff ();
         //   //mSoundMenu.text = SoundPlayer.IsSoundOn () ? " Sound Off " :" Sound On ";
         //}
         else if (menu == mRestartMenu)
         {
            sNeedRestart = true;
         }
         else if (menu == mUndoMenu)
         {
            sNeedUndo = true;
         }
      }
      
      private function GoToMainMenu ():void
      {
      
         //
         mEntityContainer.removeChild (mExitMenu);
         mEntityContainer.removeChild (mHelpMenu);
         mEntityContainer.removeChild (mRestartMenu);
    //     mEntityContainer.removeChild (mUndoMenu);
    //     mEntityContainer.removeChild (sSoundButton);
         
         mEntityContainer.removeChild (mInfoText);
         
         //sHtmlTextButton_MainMenuBr.removeEventListener( MouseEvent.CLICK, OnClickMainMenu );
         HideTextLinks ();
         
         ChangeState ( State_CloseScreen );
         
         // start load ads
     //    GameState_MainMenu.RefreshClickAwayAd ();
         
      }
      
      private function OnMenuMouseOver (event:MouseEvent):void
      {
         var menu:TextField = (event.target as TextField);
         menu.background = true;
         menu.backgroundColor = 0xDDDDFF;
         menu.textColor = 0x0;
      }
      
      private function OnMenuMouseOut (event:MouseEvent):void
      {
         var menu:TextField = (event.target as TextField);
         menu.background = false;
         menu.textColor = 0xFFFF00;
      }
      
      private function ChangeState (newState:int):void
      {
         mStateTicker = 0;
         mState = newState;
      }
      
      private var mState:int = State_OpenScreen;
      private var mStateTicker:int;
      
      private static const State_OpenScreen:int = 0;
      private static const State_InGame:int = 1;
      private static const State_CloseScreen:int = 2;
      private static const State_ShowLevelFinished:int = 3;
      private static const State_ShowGameFinished:int = 5;
      
      override public function Update (escapedTime:Number):void
      {
          mStateTicker ++;
          
          if (mLevel != null)
          {
            var timeScale:Number = mLevel.GetPhysicsTimeScale ();
            UpdateInfoText (timeScale);
          }
          
          var dScaleY:Number = 0.03;
          
         switch (mState)
         {
            case State_OpenScreen: // open screen
            {
               mTopBlackBar.scaleY -= dScaleY;
               mBottomBlackBar.scaleY -= dScaleY;
               
               if (mTopBlackBar.height <= mBlackBarMinHeight && mBottomBlackBar.height <= mBlackBarMinHeight)
               {
                  mTopBlackBar.height = mBottomBlackBar.height = mBlackBarMinHeight;
                  
                  AddOtherEntities ();
                  
                 ChangeState ( State_InGame );
               }
                  
               break;
            }
            case State_CloseScreen: // close screen
            {
               mTopBlackBar.scaleY += dScaleY;
               mBottomBlackBar.scaleY += dScaleY;
               
               if (mTopBlackBar.scaleY >= 1 && mBottomBlackBar.scaleY >= 1)
               {
                  sLevelFinishedSprite.visible = false;
                  sGameFinishedSprite.visible = false;
                  
                  mGame.SetNextGameStateID (Game.k_GameState_MainMenu);
               }
               
               break;
            }
            case State_InGame:
            {
               if (sNeedRestart)
               {
                  LoadCurrentLevel ();
                  
                  Level.SetPhysicsSimulationTimeScale (_lastTimeScale);
                  
                  trace ( " _lastTimeScale = " +  _lastTimeScale );
                  trace ( " mLevel.GetPhysicsTimeScale () = " +  mLevel.GetPhysicsTimeScale () );
                  
                  return;
               }
               
               //
               
               //
               
               mLevel.Update (escapedTime);
               
               if (mLevel.IsFinished ())
               {
                  Game.NotifyLevelFinished ();
                  
                  SoundPlayer.PlaySoundByFilePath ("finished.mp3", false);
                  
                  
                  //if (Game.sCurrentLevelIndex < Game.sLevelFilePaths.length - 1)
                  {
                     ChangeState ( State_ShowLevelFinished );
                     
                     sLevelFinishedSprite.visible = true;
                     sLevelFinishedSprite.alpha = 0.0;
                  }
                  /*
                  else
                  {
                     ChangeState ( State_ShowGameFinished );
                     
                     sGameFinishedSprite.visible = true;
                     sGameFinishedSprite.alpha = 0.0;
                     
                     sHtmlTextButton_MainMenuBr.visible = true;
                     sHtmlTextButton_MainMenuBr.alpha = 0;
                     
                     sHtmlTextButton_TapirGamesBr.visible = true;
                     sHtmlTextButton_TapirGamesBr.alpha = 0;
                  }
                  */
                  
                  var levelFile:String = Game.sLevelFilePaths [ Game.sCurrentLevelIndex ] as String;
               }
               
               break;
            }
            case State_ShowLevelFinished:
            {
               mLevel.Update (escapedTime);
               
               sLevelFinishedSprite.alpha += 0.02;
               
               if (sLevelFinishedSprite.alpha > 1.0)
               {
                  sLevelFinishedSprite.alpha = 1.0;
               }
               
               if (mStateTicker > 90)
               {
                  GoToMainMenu ();
                  // AdManager.ShowLeaderBorad (Game.mHighScore, GoToMainMenu);
               }
               
               break;
            }
            /*
            case State_ShowGameFinished:
            {
               mLevel.Update (escapedTime);
               
               sGameFinishedSprite.alpha += 0.02;
               
               sHtmlTextButton_MainMenuBr.alpha += 0.02;
               sHtmlTextButton_TapirGamesBr.alpha += 0.02;
               
               if (sGameFinishedSprite.alpha >= 1.0)
               {
                  sGameFinishedSprite.alpha = 1.0;
                  
                  //GoToMainMenu ();
               }
               
               break;
            }
            */
         }
      }
      
      
//================================================================================
      
      
      
      private function AddLevelFinishedSprite ():void
      {
         if (sLevelFinishedSprite == null)
         {
            sLevelFinishedSprite = new DialogBox ();
            
            sLevelFinishedSprite.SetText (Config.kLevelFinishedText, true);
            sLevelFinishedSprite.SetCached (true);
            sLevelFinishedSprite.SetBackgroundVisible (false);
            sLevelFinishedSprite.SetBackgroundColor (0x80FF80);
            sLevelFinishedSprite.alpha = 1;
            
            sLevelFinishedSprite.Rebuild ();
            
            sLevelFinishedSprite.x = (App::Default_Width - sLevelFinishedSprite.width) / 2;
            sLevelFinishedSprite.y = (App::Default_Height - sLevelFinishedSprite.height) / 2;
         }
         
         sLevelFinishedSprite.visible = false;
         
         mEntityContainer.addChild (sLevelFinishedSprite);
      }
      
      
      
      private function AddGameFinishedSprite ():void
      {
         if (sGameFinishedSprite == null)
         {
            sGameFinishedSprite = new DialogBox ();
            
            sGameFinishedSprite.SetText (Config.kGameFinishedText, true);
            sGameFinishedSprite.SetCached (true);
            sGameFinishedSprite.SetBackgroundVisible (false);
            sGameFinishedSprite.alpha = 1;
            
            sGameFinishedSprite.Rebuild ();
            
            sGameFinishedSprite.x = (App::Default_Width - sGameFinishedSprite.width) / 2;
            sGameFinishedSprite.y = 136 - ( sGameFinishedSprite.height) / 2;
         }
         
         sGameFinishedSprite.visible = false;
         
         mEntityContainer.addChild (sGameFinishedSprite);
      }
      
      private function AddHelpDialog ():void
      {
         if (sHelpDialog == null)
         {
            sHelpDialog = new DialogBox ();
            
            sHelpDialog.SetText (Config.kHelpDialogText, true);
            sHelpDialog.SetCached (false);
            sHelpDialog.SetBackgroundVisible (true);
            sHelpDialog.alpha = 0.9;
            
            sHelpDialog.Rebuild ();
            
            sHelpDialog.x = (App::Default_Width - sHelpDialog.width) / 2;
            sHelpDialog.y = (App::Default_Height - sHelpDialog.height) / 2;
            
         }
         
         sHelpDialog.visible = false;
         
         mEntityContainer.addChild (sHelpDialog);
      }
      
      private static var sIconSoundOn:Sprite2dModelInstance;
      private static var sIconSoundOff:Sprite2dModelInstance;
      
      private function AddSoundButton ():void
      {
         if (sSoundButton == null)
         {
            var sprite2dFile:Sprite2dFile = Engine.GetDataAsset ("misc.xSprite2d") as Sprite2dFile;
            sIconSoundOn = new Sprite2dModelInstance (sprite2dFile, 0);
            sIconSoundOn.SetAnimationID (AnimID_SoundOn);
            sIconSoundOff = new Sprite2dModelInstance (sprite2dFile, 0);
            sIconSoundOff.SetAnimationID (AnimID_SoundOff);
            
            sSoundButton = new SimpleButton ();
            UpdateSoundButton ();
            
            sSoundButton.x = App::Default_Width - sSoundButton.width - 10;
            sSoundButton.y = App::Default_Height - mBlackBarMinHeight + (mBlackBarMinHeight - sSoundButton.height) / 2;
            
            sSoundButton.addEventListener( MouseEvent.CLICK, ToggleSoundOnOff );
         }
      }
      
      private function UpdateSoundButton ():void
      {
         if (SoundPlayer.IsSoundOn ())
         {
            sSoundButton.upState = sIconSoundOn;
            sSoundButton.downState = sIconSoundOn;
            sSoundButton.overState = sIconSoundOn;
            sSoundButton.hitTestState = sIconSoundOn;
         }
         else
         {
            sSoundButton.upState = sIconSoundOff;
            sSoundButton.downState = sIconSoundOff;
            sSoundButton.overState = sIconSoundOff;
            sSoundButton.hitTestState = sIconSoundOff;
         }
      }
      
      private function ToggleSoundOnOff (event:MouseEvent):void
      {
         SoundPlayer.SwitchSoundOnOff ();
         
         UpdateSoundButton ();
         
         PlayBackgroundSound ();
      }
      
      private function PlayBackgroundSound ():void
      {
         //if (SoundPlayer.IsSoundOn ())
         //   SoundPlayer.PlaySoundByFilePath ("background_music.mp3", true);
      }
      
      
//=====================================================================================================

      //private static var sHtmlTextButton_MainMenuBr:HtmlTextButton = null;
      //private static var sHtmlTextButton_TapirGamesBr:HtmlTextButton = null;
      private static var sHtmlTextButton_TapirGamesLink:HtmlTextButton = null;
      private static var sHtmlTextButton_SponsorTextLink:HtmlTextButton = null;
      
      private static var sHtmlText_DevelopedBy:DialogBox = null;
      private static var sHtmlText_SponsoredBy:DialogBox = null;
      
      
      private function ShowTextLinks ():void
      {
         // ...
         /*
         if (sHtmlTextButton_MainMenuBr == null)
         {
            sHtmlTextButton_MainMenuBr = new HtmlTextButton (Config.kMainMenuButtonTextWithBr, true, true);
         }
         sHtmlTextButton_MainMenuBr.addEventListener( MouseEvent.CLICK, OnClickMainMenu );
         sHtmlTextButton_MainMenuBr.y = 380;
         mEntityContainer.addChild (sHtmlTextButton_MainMenuBr);
         sHtmlTextButton_MainMenuBr.visible = false;
         
         // ...
         if (sHtmlTextButton_TapirGamesBr == null)
         {
            sHtmlTextButton_TapirGamesBr = new HtmlTextButton (Config.kTapirGamesButtonTextWithBr, true, true);
            sHtmlTextButton_TapirGamesBr.addEventListener( MouseEvent.CLICK, OnClickTapirGames );
         }
         sHtmlTextButton_TapirGamesBr.y = 380;
         mEntityContainer.addChild (sHtmlTextButton_TapirGamesBr);
         sHtmlTextButton_TapirGamesBr.visible = false;
         
         //
         var gapW:int = (App::Default_Width - sHtmlTextButton_MainMenuBr.width - sHtmlTextButton_TapirGamesBr.width) / 3;
         sHtmlTextButton_MainMenuBr.x = gapW;
         sHtmlTextButton_TapirGamesBr.x = sHtmlTextButton_MainMenuBr.width + gapW + gapW;
         */
         
         
         // ...
         if (sHtmlTextButton_TapirGamesLink == null)
         {
            
            sHtmlTextButton_TapirGamesLink = new HtmlTextButton ("<P ALIGN=\"CENTER\"><FONT COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><u>http://www.TapirGames.com</u></FONT></P>"
                                                                  , false, false);
            sHtmlTextButton_TapirGamesLink.addEventListener( MouseEvent.CLICK, OnClickTapirGames );
         }
         sHtmlTextButton_TapirGamesLink.y = App::Default_Height - sHtmlTextButton_TapirGamesLink.height - 1;
         if (DomainStrategy.sShowTapirGamesOnLevelScreen)
         {
            mEntityContainer.addChild (sHtmlTextButton_TapirGamesLink);
            sHtmlTextButton_TapirGamesLink.visible = true;
         }
         
         //
         if (sHtmlTextButton_SponsorTextLink == null)
         {
            sHtmlTextButton_SponsorTextLink = new HtmlTextButton ("<P ALIGN=\"CENTER\"><FONT COLOR=\"#8080FF\" LETTERSPACING=\"0\" KERNING=\"0\"><u>" + Config.kSponsorLink + "</u></FONT></P>"
                                                                  , false, false);
            sHtmlTextButton_SponsorTextLink.addEventListener( MouseEvent.CLICK, OnClickSponsorLink );
         }
         sHtmlTextButton_SponsorTextLink.y = App::Default_Height - sHtmlTextButton_SponsorTextLink.height - 1;
         if (DomainStrategy.sShowSponsorOnLevelScreen)
         {
            mEntityContainer.addChild (sHtmlTextButton_SponsorTextLink);
            sHtmlTextButton_SponsorTextLink.visible = true;
         }
         
         //
         if (DomainStrategy.sShowTapirGamesOnLevelScreen && DomainStrategy.sShowSponsorOnLevelScreen)
         {
            if (sHtmlText_DevelopedBy == null)
            {
               sHtmlText_DevelopedBy = new DialogBox ();
               mEntityContainer.addChild (sHtmlText_DevelopedBy);
               
               sHtmlText_DevelopedBy.SetText ("Developed By: ", true);
               sHtmlText_DevelopedBy.SetBackgroundVisible (false);
               sHtmlText_DevelopedBy.SetTextColor (0xFFFF00);
               
               sHtmlText_DevelopedBy.Rebuild ();
               
            }
            sHtmlText_DevelopedBy.y = App::Default_Height - sHtmlText_DevelopedBy.height - 1;
            mEntityContainer.addChild (sHtmlText_DevelopedBy);
            sHtmlText_DevelopedBy.visible = true;
            
            
            //
            if (sHtmlText_SponsoredBy == null)
            {
               sHtmlText_SponsoredBy = new DialogBox ();
               mEntityContainer.addChild (sHtmlText_SponsoredBy);
               
               sHtmlText_SponsoredBy.SetText ("Sponsored By: ", true);
               sHtmlText_SponsoredBy.SetBackgroundVisible (false);
               sHtmlText_SponsoredBy.SetTextColor (0xFFFF00);
               
               sHtmlText_SponsoredBy.Rebuild ();
               
            }
            sHtmlText_SponsoredBy.y = App::Default_Height - sHtmlText_SponsoredBy.height - 1;
            mEntityContainer.addChild (sHtmlText_SponsoredBy);
            sHtmlText_SponsoredBy.visible = true;
            
            
            //
            var margin:int = (App::Default_Width - sHtmlTextButton_TapirGamesLink.width - sHtmlTextButton_SponsorTextLink.width
                                                - sHtmlText_DevelopedBy.width - sHtmlText_SponsoredBy.width ) / 3;
            
            //
            sHtmlText_SponsoredBy.x = margin;
            sHtmlTextButton_SponsorTextLink.x = sHtmlText_SponsoredBy.x + sHtmlText_SponsoredBy.width;
            sHtmlText_DevelopedBy.x = margin + sHtmlTextButton_SponsorTextLink.x + sHtmlTextButton_SponsorTextLink.width;
            sHtmlTextButton_TapirGamesLink.x = sHtmlText_DevelopedBy.x + sHtmlText_DevelopedBy.width;
         }
         else
         {
            sHtmlTextButton_TapirGamesLink.x  = (App::Default_Width - sHtmlTextButton_TapirGamesLink.width)  / 2;
            sHtmlTextButton_SponsorTextLink.x = (App::Default_Width - sHtmlTextButton_SponsorTextLink.width) / 2;
         }
      }
      
      private function HideTextLinks ():void
      {
         if (sHtmlTextButton_TapirGamesLink != null && sHtmlTextButton_TapirGamesLink.parent == mEntityContainer)
            mEntityContainer.removeChild (sHtmlTextButton_TapirGamesLink);
         if (sHtmlTextButton_SponsorTextLink != null && sHtmlTextButton_SponsorTextLink.parent == mEntityContainer)
            mEntityContainer.removeChild (sHtmlTextButton_SponsorTextLink)
         if (sHtmlText_DevelopedBy != null && sHtmlText_DevelopedBy.parent == mEntityContainer)
            mEntityContainer.removeChild (sHtmlText_DevelopedBy);
         if (sHtmlText_SponsoredBy != null && sHtmlText_SponsoredBy.parent == mEntityContainer)
            mEntityContainer.removeChild (sHtmlText_SponsoredBy)
      }
      
      //public function OnClickMainMenu (event:MouseEvent):void
      //{
      //   GoToMainMenu ();
      //}
      
      public static function OnClickTapirGames (event:MouseEvent):void
      {
         var url:String = "http://www.tapirgames.com";
         var request:URLRequest = new URLRequest(url);
         try {            
             navigateToURL(request, "_blank");
         }
         catch (e:Error) {
             trace ("navigateToURL error.");
         }
      }
      
      public static function OnClickTapirGames2 (event:MouseEvent):void
      {
         var url:String = "http://forum.colorinfection.com/";
         var request:URLRequest = new URLRequest(url);
         try {            
             navigateToURL(request, "_blank");
         }
         catch (e:Error) {
             trace ("navigateToURL error.");
         }
      }
      
      
      public static function OnClickDesignYourOwnLevels (event:MouseEvent):void
      {
         var request:URLRequest;
         
         //if (OnlineAPI.sIsKongregate)
         //{
         //   request = new URLRequest("http://www.kongregate.com/games/tapir/color-infection-puzzle-editor?referer=tapir");
         //}
         //else
         //{
            request = new URLRequest("http://colorinfection.appspot.com/htmls/editor_page1.html");
         //}
         
         try {            
             navigateToURL(request, "_blank");
         }
         catch (e:Error) {
             trace ("navigateToURL error.");
         }
      }
      
      public static function OnClickSponsorLink (event:MouseEvent):void
      {
         var request:URLRequest = new URLRequest(Config.kSponsorLink);
         try {            
             navigateToURL(request, "_blank");
         }
         catch (e:Error) {
             trace ("navigateToURL error.");
         }
      }
   }
}