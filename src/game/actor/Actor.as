package game.actor {
   
   import engine.display.GameDisplayObject;
   
   import engine.asset.ActorTemplate;   
   import engine.asset.ActorDefine;
   
   import game.GameEntity;
   
   import game.level.Level;
   
   
   public class Actor extends GameDisplayObject implements GameEntity
   {
      protected var mIndex:int;
      
      protected var mLevel:Level;
      
      protected var mTemplate:ActorTemplate;
      
      public var mCustomProperties:Array;
      
      public function Actor (level:Level)
      {
         mLevel = level;
      }
      
      public function SetIndex (index:int):void
      {
         mIndex = index;
      }
      
      public function LoadFromDefine (actorDefine:ActorDefine):void
      {
         mTemplate = actorDefine.mTemplate;
         
         x  = actorDefine.mPosX;
         y  = actorDefine.mPosY;
         z  = actorDefine.mZOrder;
         //scaleX = actorDefine.mFlipX ? -1.0 : 1.0;
         //scaleY = actorDefine.mFlipY ? -1.0 : 1.0;
         rotation = actorDefine.mRotation;
         scaleX = actorDefine.mScaleX;
         scaleY = actorDefine.mScaleY;
         
         mCustomProperties = actorDefine.mPropertyValues;
         
         // load appearances
         var appearanceValues:Array  = actorDefine.mAppearanceValues;
         var appearanceDefines:Array = mTemplate.mActorAppearanceDefines;
         var appearancesCount:int = appearanceValues.length; // should equals appearanceDefines.length
         
         for (var appearanceID:int  = 0; appearanceID < appearancesCount; ++ appearanceID)
            LoadAppearance (appearanceID, appearanceDefines [appearanceID], appearanceValues [appearanceID]);
      }
      
      protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
      }
      
      public function Initialize ():void
      {
      }
      
      public function Destroy ():void
      {
      }
      
      public function Update (escapedTime:Number):void
      {
      }
      
      
   }
}














