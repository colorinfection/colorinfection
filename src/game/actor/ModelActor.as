package game.actor {
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Sprite2dModelInstance;
   
   import game.res.kDefines;
   import game.res.kTemplate;
 
   
   import game.level.Level;
   
   public class ModelActor extends Actor
   {
      public function ModelActor (level:Level)
      {
         super (level);
      }
      
      public var mModel:Sprite2dModelInstance;
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_sprite2d)
         {
            var sprite2dFile:Sprite2dFile = Engine.GetDataAsset (appearanceDefine.mFilePath) as Sprite2dFile;
            mModel = new Sprite2dModelInstance (sprite2dFile, appearanceDefine.mModelID as int);
            
            var animationID:int = appearanceValue as int;
            mModel.SetAnimationID (animationID);
            
            addChild (mModel);
         }
      }
   }
}