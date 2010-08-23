package game.state {
   
   import flash.display.DisplayObject
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import flash.events.MouseEvent;
   
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   
   import flash.display.MovieClip;
   
   
   import engine.Engine;
   
   import game.Game;
   
   import game.GameState;
   
   import game.display.MainMenuLevelItem;
   import game.display.HtmlTextButton;
   import game.display.ImageButton;
   import game.display.DialogBox;
   
   import game.Config;
   import game.KeyInput;
   
   import game.display.TargetStar;
   
   import game.DomainStrategy;
   
   import game.AdManager;
   
   import game.OnlineAPI;
   
   
   public class GameState_MainMenu extends GameState {
   
      
      private var mEntityContainer:Sprite;
      private var mBlackBackground:Shape;
      
      private var mTitleLogo:Bitmap;
      private var mTitleText:DialogBox;
      
      private var mHelpText:DialogBox;
      private var mStatText:DialogBox;
      
      private var mTitleTextColor:uint = 0xFFFFDD;
      
      private var mLevelMenuItems:Array;
      private var mTargetStar:TargetStar;
      
      private var mClickawayAdContainer:Sprite;
      
      public static const AdsPlacementTopLine:int = 322;
      public static const LevelSelectBottomLine:int = AdsPlacementTopLine - 44;
      private static const LevelMenuItemsCount:int = 10;
      
      
      //
      //public static var sHtmlTextButton_TapirGames:HtmlTextButton = null;
      //public static var sHtmlTextButton_MyDailyGameLogo:ImageButton = null;
      
      public static var sSubmitStatBotton:HtmlTextButton = null;
      
      public static var sSponsorLinkBotton:HtmlTextButton = null;
      
      public static var sEditLevelBotton:HtmlTextButton = null;
      
//=============================================================================================
      
      
      public function GameState_MainMenu (game:Game)
      {
         super (game);
      }
      
      override public function Initialize ():void
      {
         //
         mBlackBackground = new Shape();
         mBlackBackground.graphics.beginFill(0x0);
         mBlackBackground.graphics.lineStyle(0, 0x0);
         mBlackBackground.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height);
         mBlackBackground.graphics.endFill();
         mGame.addChild(mBlackBackground);
         
         //
         mEntityContainer = new Sprite ();
         mEntityContainer.alpha = 0;
         mGame.addChild (mEntityContainer);
         
         // 
         
         
         //
         var bg:Shape = new Shape();
         bg.graphics.beginFill(0x0);
         bg.graphics.lineStyle(0, 0x0);
         bg.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height);
         bg.graphics.endFill();
         mEntityContainer.addChild (bg);
         
         //
         var titleMargin:uint = 10;
         
         //
         /*
         mTitleLogo = new Bitmap (Engine.GetDataAsset ("logo.png") as BitmapData);
         mEntityContainer.addChild (mTitleLogo);
         
         mTitleLogo.x = (App::Default_Width - mTitleLogo.width) / 2;
         mTitleLogo.y = titleMargin;
         */
         
         mTitleText = new DialogBox ();
         mEntityContainer.addChild (mTitleText);
         
         
         mTitleText.SetText (Config.kTitleText, true);
         mTitleText.SetCached (true);
         mTitleText.SetBackgroundVisible (false);
         
         mTitleText.Rebuild ();
         
         mTitleText.x = (App::Default_Width - mTitleText.width) / 2;
         mTitleText.y = titleMargin;
         
         /*
         trace ("App::Default_Width = " + App::Default_Width);
         trace ("mGame.stage.width = " + mGame.stage.width);
         trace ("mGame.stage.scaleX = " + mGame.stage.scaleX);
         trace ("mTitleText.width = " + mTitleText.width);
         trace ("mTitleText.x = " + mTitleText.x);
         trace ("mTitleText.scaleX = " + mTitleText.scaleX);
         var theparent:DisplayObject = mGame;
         var indent:String = "";
         while (theparent != null)
         {
            trace (indent + ": " + theparent + ", scaleX = " + theparent.scaleX);
            theparent = theparent.parent;
            indent = indent + "   ";
         }
         */
         
         //         
         //var helpTextTopLinePos:int = mTitleLogo.y + mTitleLogo.height + titleMargin;
         var helpTextTopLinePos:int = mTitleText.y + mTitleText.height + titleMargin;
         var levelSelectTopLinePos:int = helpTextTopLinePos + 90;
         var levelSelectBottomLinePos:int = LevelSelectBottomLine;
         var adsPlacementTopLinePos:int = AdsPlacementTopLine;
         
         //
         var line:Shape 
         
         line = new Shape ();
         line.graphics.lineStyle(1, 0x0000FF);
         line.graphics.moveTo ( 50, 0 );
         line.graphics.lineTo ( App::Default_Width - 50, 0 );
         line.y = helpTextTopLinePos;
         mEntityContainer.addChild (line);
         
         //
         mHelpText = new DialogBox ();
         mEntityContainer.addChild (mHelpText);
         
         mHelpText.SetText (Config.kHelpDialogText2, true);
         mHelpText.SetCached (true);
         mHelpText.SetBackgroundVisible (false);
         mHelpText.SetTextColor (0xaaaaff);
         
         mHelpText.Rebuild ();
         
         mHelpText.x = (App::Default_Width - mHelpText.width) / 2;
         mHelpText.y = helpTextTopLinePos + (levelSelectTopLinePos - helpTextTopLinePos - mHelpText.height) / 2;
         
         
         // lines
         line = new Shape ();
         line.graphics.lineStyle(1, 0x0000FF);
         line.graphics.moveTo ( 50, 0 );
         line.graphics.lineTo ( App::Default_Width - 50, 0 );
         line.y = levelSelectTopLinePos;
         mEntityContainer.addChild (line);
         
         line = new Shape ();
         line.graphics.lineStyle(1, 0x0000FF);
         line.graphics.moveTo ( 50, 0 );
         line.graphics.lineTo ( App::Default_Width - 50, 0 );
         line.y = levelSelectBottomLinePos;
         mEntityContainer.addChild (line);
         
         line = new Shape ();
         line.graphics.lineStyle(1, 0x0000FF);
         line.graphics.moveTo ( 50, 0 );
         line.graphics.lineTo ( App::Default_Width - 50, 0 );
         line.y = adsPlacementTopLinePos;
         mEntityContainer.addChild (line);
         
         // score number
         mStatText = new DialogBox ();
         mEntityContainer.addChild (mStatText);
         
         var scoreStr:String = "Current Score:   <FONT FACE=\"Times New Roman\" SIZE=\"23\" COLOR=\"#FFFF80\" LETTERSPACING=\"0\" KERNING=\"0\"><b>" + Game.mHighScore + " </b></FONT>";
         if (Game.FinishedAllLevels ())
            scoreStr = "<FONT FACE=\"Times New Roman\" SIZE=\"14\" COLOR=\"#C0FFC0\" LETTERSPACING=\"0\" KERNING=\"0\"><i> All puzzles are solved! Cool!  </i></FONT>" + scoreStr;
         mStatText.SetText (scoreStr, true);
         mStatText.SetCached (true);
         mStatText.SetBackgroundVisible (false);
         mStatText.SetTextColor (0xaaaaff);
         
         mStatText.Rebuild ();
         
         //mStatText.x = (App::Default_Width - mStatText.width) / 2;
         mStatText.y = levelSelectBottomLinePos + (adsPlacementTopLinePos - levelSelectBottomLinePos - mStatText.height) / 2;
         mStatText.x = (App::Default_Width - mStatText.width) / 2;
         
         if (OnlineAPI.sIsMindJolt)
            ;
         else if (OnlineAPI.sIsKongregate && ! OnlineAPI.sIsGuest)
            ;
         //if ( !OnlineAPI.sIsKongregate || OnlineAPI.sIsGuest )
         else
         {
            // sumbit button
            if (sSubmitStatBotton == null)
            {
               sSubmitStatBotton = new HtmlTextButton ("<FONT FACE=\"Times New Roman\" SIZE=\"12\" COLOR=\"#0000FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Submit</b></FONT>", 
                                                   true, true, 0xC0C080, 0x80CC80, 0x000000, 0x8080A0, 1, 2);
               sSubmitStatBotton.addEventListener( MouseEvent.CLICK, OnClickSubmitStat );
            }
            //sSubmitStatBotton.x = mStatText.x  + mStatText.width;
            sSubmitStatBotton.y = levelSelectBottomLinePos + (adsPlacementTopLinePos - levelSelectBottomLinePos - sSubmitStatBotton.height) / 2;
            mEntityContainer.addChild (sSubmitStatBotton);
            
            var marginx:int = (App::Default_Width - mStatText.width - sSubmitStatBotton.width) / 2;
            mStatText.x = marginx;
            sSubmitStatBotton.x = mStatText.x  + mStatText.width;
         }
         
         
         // level select
         
         var filePaths:Array = Game.sLevelFilePaths;
         var levelsCount:uint = filePaths.length;
         
         if (! DomainStrategy.sShowExtraLevels)
            levelsCount -= 5;
         
         var maxCols:uint = LevelMenuItemsCount;
         
         var cols:uint = levelsCount > maxCols ? maxCols : levelsCount;
         var rows:uint = (levelsCount + maxCols - 1) / maxCols;
         
         var blockWidth:uint = 30;
         var blockHeight:uint = 30;
         
         var blockGapX:uint = 6;
         var blockGapY:uint = 6;
         
         var startX:int = ( App::Default_Width - (cols * blockWidth + (cols - 1) * blockGapX) ) / 2;
         var startY:int = levelSelectTopLinePos + ( levelSelectBottomLinePos - levelSelectTopLinePos - (rows * blockHeight + (rows - 1) * blockGapY) ) / 2;
         
         var row:uint = 0;
         var col:uint = 0;
         var bx:int = startX;
         var by:int = startY
         
         mLevelMenuItems = new Array (levelsCount);
         
         for (var levelID:uint = 0; levelID < levelsCount; ++ levelID)
         {
            var menuItem:MainMenuLevelItem = new MainMenuLevelItem (levelID, Game.sLevelFinisheds [levelID], Game.sLevelLockeds [levelID], blockWidth, blockHeight);
            if ( ! Game.sLevelLockeds [levelID] )
               menuItem.addEventListener( MouseEvent.CLICK, OnLevelMenuItemClick );
            
            mLevelMenuItems [levelID] = menuItem;
            
            menuItem.x = bx;
            menuItem.y = by;
            
            mEntityContainer.addChild(menuItem);
            
            //
            
            // 
            ++ col;
            bx += blockWidth + blockGapX;
            
            if (col >= maxCols)
            {
               col = 0;
               bx = startX;
               
               ++ row;
               by += blockHeight + blockGapY;
            }
            
            if (levelID == Game.sCurrentLevelIndex)
            {
               mTargetStar = new TargetStar (blockWidth / 4);
               mTargetStar.SetColor (0x00ff00);
               mTargetStar.x = menuItem.x + menuItem.width / 2;
               mTargetStar.y = menuItem.y + menuItem.height / 2;
            }
         }
         
         // edit level
         var endX:int = startX + maxCols * (blockWidth + blockGapX) - blockGapX;
         
         sEditLevelBotton = new HtmlTextButton ("<FONT FACE=\"Times New Roman\" SIZE=\"12\" COLOR=\"#0000FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Design your own puzzles?</b></FONT>", 
                                                   true, true, 0xC0C080, 0x80CC80, 0x000000, 0x8080A0, 1, 2);
         sEditLevelBotton.addEventListener( MouseEvent.CLICK, OnClickLevelEdit );
         //sEditLevelBotton.x = mStatText.x - sEditLevelBotton.width - 30;
         //sEditLevelBotton.y = levelSelectBottomLinePos + (adsPlacementTopLinePos - levelSelectBottomLinePos - sEditLevelBotton.height) / 2;
         //sEditLevelBotton.x = (App::Default_Width - mStatText.width) / 2 + (blockWidth + blockGapX) / 2;
         sEditLevelBotton.x = endX - sEditLevelBotton.width;
         sEditLevelBotton.y = by + blockHeight - sEditLevelBotton.height;
         mEntityContainer.addChild (sEditLevelBotton);
         

         
         //
         mEntityContainer.addChild(mTargetStar);
         
         //
         KeyInput.mComfirmKeyPressed = false;
         
         // wired? to gain key focus
         mGame.stage.focus = mEntityContainer;
         mGame.stage.focus = null;
         
         
         //
         var marginy:int;
         
         // ads container
         var adContainerWidth:int = 360;
         
         if (!DomainStrategy.sShowClickAwayAd && !DomainStrategy.sShowTapirGamesAd)
            adContainerWidth = 0;
         
         mClickawayAdContainer = new Sprite ();
         mEntityContainer.addChild (mClickawayAdContainer);
         mClickawayAdContainer.x = App::Default_Width / 2;
         mClickawayAdContainer.y = adsPlacementTopLinePos + (App::Default_Height - adsPlacementTopLinePos) / 2;
         
         // sponser link
         if (DomainStrategy.sShowSponsorOnMainmenuScreen)
         {
            // sponsor link button
            if (sSponsorLinkBotton == null)
            {
               sSponsorLinkBotton = new HtmlTextButton ("<P ALIGN=\"CENTER\"><FONT FACE=\"Times New Roman\" SIZE=\"20\" COLOR=\"#0000FF\" LETTERSPACING=\"0\" KERNING=\"0\"><b>Play more physics games<br>at<br>" + Config.kSponsorName + "</b></FONT></P>", 
                                                      true, true, 0xC0C080, 0x80CC80, 0x000000, 0x8080A0, 1, 2);
               sSponsorLinkBotton.addEventListener( MouseEvent.CLICK, GameState_Level.OnClickSponsorLink );
            }
            mEntityContainer.addChild (sSponsorLinkBotton);
            
            //
            marginx = (App::Default_Width - sSponsorLinkBotton.width - adContainerWidth) / 2;
            marginy = (App::Default_Height - adsPlacementTopLinePos - sSponsorLinkBotton.height) / 2;
            sSponsorLinkBotton.x = marginx;
            sSponsorLinkBotton.y = adsPlacementTopLinePos + marginy;
            
            mClickawayAdContainer.x = App::Default_Width - adContainerWidth / 2;
         }
         
         // load ads
         AdManager.ShowTapirGamesAd (mClickawayAdContainer);
         AdManager.ShowClickAwayAd (mClickawayAdContainer);
         
      }
      
      public static function OnClickSubmitStat (event:MouseEvent):void
      {
         //if (OnlineAPI.sIsMindJolt)
         //   OnlineAPI.MindJolt_UpdateOnlineData (Game.mHighScore);
         //else
            AdManager.ShowLeaderBorad (Game.mHighScore, null);
      }
      
      public function OnClickLevelEdit (event:MouseEvent):void
      {
         GameState_Level.OnClickDesignYourOwnLevels (null);
      }
      
      // Event handler invoked whenever the user presses the button
      private function OnLevelMenuItemClick( event:MouseEvent ):void 
      {
         Game.sCurrentLevelIndex = (event.target as MainMenuLevelItem).GetLevelIndex ();
         
         mState = 2;
      }
      
      override public function Destroy ():void
      {
         // ads
         //HideClickAwayAd (mGame.stage);
         AdManager.HideTapirGamesAd ();
         AdManager.HideClickAwayAd ();
         
         // RefreshClickAwayAd ();
         // putting here will make game in level slow.
         // now put at the moment level just finished
         
         
         //
         mGame.removeChild (mBlackBackground);
         mGame.removeChild (mEntityContainer);
      }
      
      private var mState:int = 0;
      override public function Update (escapedTime:Number):void
      {
         AdManager.UpdateClickAwayAd ();
         
         var dAlpha:Number = 0.075;
         switch (mState)
         {
            case 0:
               if (mEntityContainer.alpha >= 1)
               {
                  mState = 1;
                  mEntityContainer.alpha = 1;
               }
               else
               {
                  mEntityContainer.alpha += dAlpha;
               }
               break;
            case 1:
               mTargetStar.UpdateAnimation (escapedTime + escapedTime);
               
               var levelsCount:int = Game.sLevelFilePaths.length;
               var newLevelID:int = Game.sCurrentLevelIndex;
               var row:int = Game.sCurrentLevelIndex / LevelMenuItemsCount;
               var col:int = Game.sCurrentLevelIndex - row * LevelMenuItemsCount;
               var rows:int = (levelsCount + LevelMenuItemsCount - 1) / LevelMenuItemsCount;
               if (KeyInput.mLeftKeyPressed)
               {
                  do
                  {
                      -- col;
                     if (col < 0)
                        col += LevelMenuItemsCount;
                     newLevelID = row * LevelMenuItemsCount + col;
                     if (newLevelID >= levelsCount)
                        newLevelID = levelsCount;
                  }
                  while (Game.sLevelLockeds [newLevelID]);
               }
               else if (KeyInput.mRightKeyPressed)
               {
                  do
                  {
                      ++ col;
                     if (col >= LevelMenuItemsCount)
                        col -= LevelMenuItemsCount;
                     newLevelID = row * LevelMenuItemsCount + col;
                     if (newLevelID >= levelsCount)
                        newLevelID = row * LevelMenuItemsCount;
                  }
                  while (Game.sLevelLockeds [newLevelID]);
               }
               else if (KeyInput.mUpKeyPressed)
               {
                  do
                  {
                     -- row;
                     if (row < 0)
                        row += rows;
                     newLevelID = row * LevelMenuItemsCount + col;
                     if (newLevelID >= levelsCount)
                        newLevelID -= LevelMenuItemsCount;
                  }
                  while (Game.sLevelLockeds [newLevelID]);
               }
               else if (KeyInput.mDownKeyPressed)
               {
                  do
                  {
                     ++ row;
                     if (row >= rows )
                        row -= rows;
                     newLevelID = row * LevelMenuItemsCount + col;
                     if (newLevelID >= levelsCount)
                        newLevelID = col;
                  }
                  while (Game.sLevelLockeds [newLevelID]);
               }
               
               if ( ! Game.sLevelLockeds [newLevelID] )
               {
                  mTargetStar.x = mLevelMenuItems [newLevelID].x + mLevelMenuItems [newLevelID].width / 2;
                  mTargetStar.y = mLevelMenuItems [newLevelID].y + mLevelMenuItems [newLevelID].height / 2;
                  
                  Game.sCurrentLevelIndex = newLevelID;
                  
                  if (KeyInput.mComfirmKeyPressed)
                  {
                     mState = 2;
                  }
               }
               else
                  trace ("a locked level is selected.");
               
               KeyInput.ClearKeys ();
               
               break;
            case 2:
            case 3:
               if (mEntityContainer.alpha < dAlpha)
               {
                  mEntityContainer.alpha = 0;
                  if (mState == 2)
                     mGame.SetNextGameStateID (Game.k_GameState_Level);
                  else
                     mGame.SetNextGameStateID (Game.k_GameState_LevelEditor);                  
               }
               else
               {
                  mEntityContainer.alpha -= dAlpha;
                  
                  // ads
                  //if (mClickAwayAdMC != null)
                  //   mClickAwayAdMC.alpha = mEntityContainer.alpha;
               }
               
               break;
         }
      }
      
      private function CalColor (color:uint, a:Number):uint
      {
         var r:uint = (color && 0xFF0000) >> 16;
         var g:uint = (color && 0xFF00) >> 8;
         var b:uint = (color && 0xFF) >> 0;
         
         if (a < 0) a = 0;
         if (a > 1) a = 1;
         
         r *= a;
         g *= a;
         b *= a;
         
         return (r << 16) + (g << 8) + b;
      }
      
   }
}