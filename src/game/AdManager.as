package game {
   
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   import flash.events.MouseEvent;
   
   import engine.Engine;
   
   import game.display.ImageButton;
   import game.state.GameState_Level;
   
   import game.Preloader;
   
   import mochi.MochiAd;
   
   import mochi.MochiScores;
   
   public class AdManager {
      
      
//=====================================================================================

      [Embed(source="../../res/tapirgames_1.jpg")]
      private static var TapirGamesLogo:Class;

      //
      public static var mTapirGamesAd:ImageButton;
      
      public static function ShowTapirGamesAd (container:DisplayObjectContainer, posX:int = 0, posY:int = 0, alignX:int = 0, alignY:int = 0):void
      {
         HideTapirGamesAd ();
         
         if (! DomainStrategy.sShowTapirGamesAd)
            return;
         
         if (mTapirGamesAd == null)
         {
            //mTapirGamesAd = new ImageButton (Engine.GetDataAsset ("tapirgames_1.jpg") as BitmapData);
            mTapirGamesAd = new ImageButton (new TapirGamesLogo ().bitmapData as BitmapData);
            mTapirGamesAd.addEventListener (MouseEvent.CLICK, GameState_Level.OnClickTapirGames2 );
         }
         
         container.addChild(mTapirGamesAd);
         mTapirGamesAd.visible = true;
         
         if (alignX < 0)
            mTapirGamesAd.x = posX;
         else if (alignX > 0)
            mTapirGamesAd.x = posX - mTapirGamesAd.width;
         else // center
            mTapirGamesAd.x = posX - mTapirGamesAd.width / 2;
         
         if (alignY < 0)
            mTapirGamesAd.y = posY;
         else if (alignY > 0)
            mTapirGamesAd.y = posY - mTapirGamesAd.height;
         else // center
            mTapirGamesAd.y = posY - mTapirGamesAd.height / 2;
      }
      
      public static function HideTapirGamesAd ():void
      {
         if (mTapirGamesAd != null)
         {
            if (mTapirGamesAd.parent != null)
               mTapirGamesAd.parent.removeChild (mTapirGamesAd)
            mTapirGamesAd.visible = false;
         }
      }
      
//=====================================================================================
      
      //
      public static var mClickAwayAdMC:MovieClip;
      public static const ClickAwayAdWidth:int = 300;
      public static const ClickAwayAdHeight:int = 250;
      
      
      //
      public static var mLastPlayerName:String;
      
      public static function ShowClickAwayAd (container:DisplayObjectContainer, posX:int = 0, posY:int = 0, alignX:int = 0, alignY:int = 0):void
      {
         HideClickAwayAd ();
         
         if (! DomainStrategy.sShowClickAwayAd)
            return;
         
         mClickAwayAdMC = new MovieClip ();
         container.addChild(mClickAwayAdMC);
         mClickAwayAdMC.visible = true;
         
         if (alignX < 0)
            mClickAwayAdMC.x = posX;
         else if (alignX > 0)
            mClickAwayAdMC.x = posX - ClickAwayAdWidth;
         else // center
            mClickAwayAdMC.x = posX - ClickAwayAdWidth / 2;
         
         if (alignY < 0)
            mClickAwayAdMC.y = posY;
         else if (alignY > 0)
            mClickAwayAdMC.y = posY - ClickAwayAdHeight;
         else // center
            mClickAwayAdMC.y = posY - ClickAwayAdHeight / 2;
         
         try
         {
            var opts:Object = {id: Preloader._mochiads_game_id, clip: mClickAwayAdMC};
            MochiAd.showClickAwayAd(opts);
         }
         catch (e:Error)
         {
         }
      }
      
      public static function HideClickAwayAd ():void
      {
         if (mClickAwayAdMC != null)
         {
            if (mClickAwayAdMC.parent != null)
               mClickAwayAdMC.parent.removeChild (mClickAwayAdMC)
            mClickAwayAdMC.visible = false;
         }
      }
      
      public static function UpdateClickAwayAd ():void
      {
         if (mClickAwayAdMC != null && mClickAwayAdMC.width > 0)
         {
            if (mTapirGamesAd != null)
               HideTapirGamesAd ();
         }
      }
      
      
//=====================================================================================
      
      public static function ShowLeaderBorad (score:int, exitCallback:Function):void
      {
         mUserOnCloseLeaderBorad = exitCallback;
         
         if (mLastPlayerName != null)
            MochiScores.showLeaderboard({score: score, onClose: OnCloseLeaderBorad}); 
         else
            MochiScores.showLeaderboard({name: mLastPlayerName, score: score, onClose: OnCloseLeaderBorad}); 
      }
      
      private static var mUserOnCloseLeaderBorad:Function;
      private static function OnCloseLeaderBorad ():void
      {
         MochiScores.getPlayerInfo (Preloader.sPreloader, OnPlayerInfoReceived);
         //MochiScores.getPlayerInfo (null, OnPlayerInfoReceived);
         if (mUserOnCloseLeaderBorad != null)
            mUserOnCloseLeaderBorad ();
         mUserOnCloseLeaderBorad = null;
      }
      
      private static function OnPlayerInfoReceived (info:Object):void 
      {
         trace ("info = " + info);
         
         if (info.name != undefined) 
         {
               mLastPlayerName = info.name;
         }
      }
   }
}