
package game.level {
   
   import game.actor.Actor;
   
   public class LevelStatusInfo
   {
      public static var sAutoSavedLevelHistoryStatusInfos:Array;
      
      public static var sNumAutoSavedLevelHistoryStatusInfos:int = 0;
      public static function ClearLevelHistoryInfos ():void
      {
         sNumAutoSavedLevelHistoryStatusInfos = 0;
         
         if (sAutoSavedLevelHistoryStatusInfos == null || sAutoSavedLevelHistoryStatusInfos.length > 1000)
            sAutoSavedLevelHistoryStatusInfos = new Array (1000);
         else
         {
            for (var i:int = 0; i < sAutoSavedLevelHistoryStatusInfos.length; ++i)
               sAutoSavedLevelHistoryStatusInfos [i] = null;
         }
      }
      
      public static function AddAutoSavedLevelHistoryStatusInfo (statusInfo:LevelStatusInfo):void
      {
         sAutoSavedLevelHistoryStatusInfos [sNumAutoSavedLevelHistoryStatusInfos ++] = statusInfo;
      }
      
      public static function PopAutoSavedLevelHistoryStatusInfo ():LevelStatusInfo
      {
         if (sNumAutoSavedLevelHistoryStatusInfos <= 0)
            return null;
         
         -- sNumAutoSavedLevelHistoryStatusInfos;
         
         return sAutoSavedLevelHistoryStatusInfos [sNumAutoSavedLevelHistoryStatusInfos];
      }
      
      
//===============================================================
      
      public var mTimeStep:int;
      public var mBoxActorsInfo:Array;
      
      public function LevelStatusInfo (level:Level)
      {


      }
      
      
   }
}
