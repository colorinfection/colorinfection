package game {
   
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   import flash.display.Sprite;
   
   import flash.net.SharedObject;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObjectFlushStatus;
   

   
   import game.state.GameState_Startup;
   import game.state.GameState_MainMenu;
   import game.state.GameState_Level;
   import game.state.GameState_LevelEditor;
   import game.ResLoader;
   
   import game.level.Level;
   
   public class Game extends Sprite 
   {
      
      private var mGameStateID:int;
      private var mGameState:GameState;
      
      private var mTopContainer:DisplayObjectContainer;
      
      
      public static var k_GameState_i:int = -1;
      public static const k_GameState_Invalid:int = k_GameState_i ++;
      public static const k_GameState_Startup:int = k_GameState_i ++;
      public static const k_GameState_MainMenu:int = k_GameState_i ++;
      public static const k_GameState_Level:int = k_GameState_i ++;;
      public static const k_GameState_LevelEditor:int = k_GameState_i ++;;

      
      public function CreateGameState (gameStateID:int):GameState
      {
         switch (gameStateID)
         {
         case k_GameState_Startup:
            return new GameState_Startup (this);
         case k_GameState_MainMenu:
            return new GameState_MainMenu (this);
            return null;
         case k_GameState_Level:
            return new GameState_Level (this);
         case k_GameState_LevelEditor:
            return new GameState_LevelEditor (this);
         default:
            return null;
         }
      }
      
      
      public function Game ()
      {

         
         ResLoader.Initialize ();
         
         mGameStateID = k_GameState_Invalid;
         mGameState   = null;
         
         SetNextGameStateID (k_GameState_Startup);
         
      }
      

      
      private var mNextGameStateID:int;
      public function SetNextGameStateID (newStateID:int):void
      {
         mNextGameStateID = newStateID;
      }
      
      
      private function ChangeGameState (newStateID:int):void
      {
         if (mGameState != null)
            mGameState.Destroy ();
            
         mGameStateID = newStateID;
         mGameState   = CreateGameState (mGameStateID);
         
         if (mGameState != null )
            mGameState.Initialize ();
         
         mNextGameStateID = mGameStateID;
      }
      
      public function Update (escapedTime:Number):void
      {
         if (mNextGameStateID != mGameStateID)
         {
            ChangeGameState (mNextGameStateID);
         }
         
         if (mGameState != null )
         {
            mGameState.Update (escapedTime);
         }
      }
      
//==========================================================================
// 
//==========================================================================
      
      public static var sCurrentLevelIndex:uint = 0;
      public static var sLevelFilePaths:Array = new Array ();
      public static var sLevelFinisheds:Array = new Array ();
      public static var sLevelLockeds:Array = new Array ();
      public static function RegisterLevel (levelPath:String):void
      {
         var levelID:int = sLevelFilePaths.length;
         sLevelFilePaths [ levelID ] = levelPath;
         sLevelFinisheds [ levelID ] = false;
         sLevelLockeds   [ levelID ] = false;
      }
      
      public static function FinishedAllLevels ():Boolean
      {
         return mFinishedLevels == sLevelFinisheds.length;
      }
      
      public static function NotifyLevelFinished ():void
      {
         var sendOnlineData:Boolean = ! sLevelFinisheds [sCurrentLevelIndex];
         
         sLevelFinisheds [sCurrentLevelIndex] = true;
         
         var maxUnlockedLevelID:int = sCurrentLevelIndex + 3;
         if (maxUnlockedLevelID >= sLevelLockeds.length)
            maxUnlockedLevelID = sLevelLockeds.length - 1;
         
         var levelID:int;
         
   //      for ( levelID = sCurrentLevelIndex + 1; levelID <= maxUnlockedLevelID; ++ levelID)
   //         sLevelLockeds [levelID] = false;
         
         //
         SaveGame ();
         
         //
         UpdateStatistics (sendOnlineData);
      }
      
      public static var mHighScore:int = 0;
      public static var mFinishedLevels:int = 0;
      private static function UpdateStatistics (uploadStat:Boolean):void
      {
         //
         var difficuty:int;
         
         //
         var numFinishedLevels:int = 0;
         var numFinishedNormalLevels:int = 0;
         var numFinishedHardLevels:int = 0;
         var numFinishedImpossibleLevels:int = 0;
         
         var normalScore:int = 0;
         var hardScore:int = 0;
         var impossibleScore:int = 0;
         var highScore:int = 0;
         
         var AllNormalLevelsFinished:Boolean = true;
         var AllHardLevelsFinished:Boolean = true;
         var AllImpossibleLevelsFinished:Boolean = true;
         var AllLevelsFinished:Boolean = true;
         
         for (var levelID:int = 0; levelID < sLevelFinisheds.length; ++ levelID)
         {
            difficuty = Config.kLevelDifficuties [levelID];
            
            if (sLevelFinisheds [levelID])
            {
               if (difficuty <= 3)
               {
                  numFinishedNormalLevels ++;
                  
                  normalScore += difficuty * 1000;
               }
               else if (difficuty == 4)
               {
                  numFinishedHardLevels ++;
                  
                  hardScore += difficuty * 1000;
               }
               else // if (difficuty >= 5)
               {
                  numFinishedImpossibleLevels ++;
                  
                  impossibleScore += difficuty * 1000;
               }
               
               numFinishedLevels ++;
               highScore += difficuty * 1000;
            }
            else
            {
               if (difficuty <= 3)
                  AllNormalLevelsFinished = false;
               else if (difficuty == 4)
                  AllHardLevelsFinished = false;
               else if (difficuty >= 5)
                  AllImpossibleLevelsFinished = false;
               
               AllLevelsFinished = false;
            }
         }
         
         //
         mHighScore = highScore;
         mFinishedLevels = numFinishedLevels;
         
     //    var numUnlockedLevels:int = 0;
     //    for (levelID = 0; levelID < sLevelLockeds.length; ++ levelID)
     //    {
     //       if (! sLevelLockeds [levelID])
     //          numUnlockedLevels = levelID + 1;
     //    }
         
         
         if (uploadStat)
         {
            OnlineAPI.UpdateOnlineData (
                                    numFinishedLevels, highScore, 
                                    normalScore, hardScore, impossibleScore,
                                    AllNormalLevelsFinished, AllHardLevelsFinished, AllImpossibleLevelsFinished, AllLevelsFinished);
         }
      }
      
      
//==========================================================================
// inline api
//==========================================================================
      

      
//==========================================================================
// save and load
//==========================================================================

      public static function LoadGame ():void
      {
         try
         {
            var so:SharedObject = SharedObject.getLocal (Config.kGameDataName);
            var levelFinisheds:Array = so.data.levelFinisheds;
            //var levelLockeds:Array = so.data.levelLockeds;
            
            var levelID:int;
            var nLevels:int;
            
            trace ("levelFinisheds.length = " + levelFinisheds.length);
            //trace ("levelLockeds.length = " + levelLockeds.length);
            
            nLevels = levelFinisheds.length < sLevelFinisheds.length ? levelFinisheds.length : sLevelFinisheds.length;
            for (levelID = 0; levelID < nLevels; ++ levelID)
            {
               sLevelFinisheds [levelID] = levelFinisheds [levelID];
            }
            
            //nLevels = levelLockeds.length < sLevelLockeds.length ? levelLockeds.length : sLevelLockeds.length;
            //for (levelID = 0; levelID < nLevels; ++ levelID)
            //{
            //      sLevelLockeds [levelID] = levelLockeds [levelID];
            //}
            
            if (Config.kForDebug)
            {
               for (levelID = 0; levelID < sLevelLockeds.length; ++ levelID)
               {
                  sLevelLockeds [levelID] = false;
               }
            }
            
            
            //
            UpdateStatistics (false);
            
            //
            
            trace ("so.data.modeColorBlind = " + so.data.modeColorBlind);
            Level.SetColorBlindMode (so.data.modeColorBlind == true);
         }
         catch ( e:Error ) 
         {
            trace ("LoadGame error: " + e);
         }
      }
      
      private static function SaveGame ():void
      {
         try 
         {
            if (Config.kForDebug)
            {
               for (var levelID:int = 0; levelID < sLevelLockeds.length; ++ levelID)
               {
                  sLevelLockeds [levelID] = false;
               }
            }
            
            // 
            var so:SharedObject = SharedObject.getLocal (Config.kGameDataName);
            so.data.levelFinisheds = sLevelFinisheds;
            so.data.modeColorBlind = Level.IsColorBlindMode ();
         //   so.data.levelLockeds  = sLevelLockeds;
         
            var flushResult:String = so.flush(2000);
            
            
            // If the flush operation is pending, add an event handler for
            // netStatus to determine if the user grants or denies access.
            // Otherwise, just check the result.
            if ( flushResult == SharedObjectFlushStatus.PENDING ) {
               // Add an event handler for netStatus so we can check if the user
               // granted enough disk space to save the shared object. Invoke
               // the OnFlushStatus method when the netStatus event is raised.
               so.addEventListener( NetStatusEvent.NET_STATUS, OnFlushStatus );
            } 
            else if ( flushResult == SharedObjectFlushStatus.FLUSHED ) 
            {
               // Saved successfully. Place any code here that you want to
               // execute after the data was successfully saved.
            }
         } 
         catch ( e:Error ) 
         {
            trace ("SaveGame error: " + e);
            
            // This means the user has the local storage settings to 'Never.'
            // If it is important to save your data, you may want to alert the
            // user here. Also, if you want to make it easy for the user to change
            // his settings, you can open the local storage tab of the Player
            // Settings dialog box with the following code:
            // Security.showSettings( SecurityPanel.LOCAL_STORAGE );.
         }
         
         
      }
      
      // Define the OnFlushStatus() function to handle the shared object's
      // status event that is raised after the user makes a selection from
      // the prompt that occurs when flush( ) returns "pending."
      private static function OnFlushStatus( event:NetStatusEvent ):void 
      {
         if ( event.info.code == "SharedObject.Flush.Success" ) 
         {
            // If the event.info.code property is "SharedObject.Flush.Success",
            // it means the user granted access. Place any code here that
            // you want to execute when the user grants access.
         } 
         else if ( event.info.code == "SharedObject.Flush.Failed" ) 
         {
            // If the event.info.code property is "SharedObject.Flush.Failed", it
            // means the user denied access. Place any code here that you
            // want to execute when the user denies access.
         }
         
         // Remove the event listener now since we only needed to listen once
         SharedObject.getLocal (Config.kGameDataName).removeEventListener( NetStatusEvent.NET_STATUS, OnFlushStatus );
      };      
       
      
      
   }
}