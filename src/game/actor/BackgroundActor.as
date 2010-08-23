
package game.actor {
   
   import flash.utils.ByteArray;
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Tiled2dBackgroundInstance;
   
   import game.res.kDefines;
   import game.res.kTemplate;
   
   import game.level.Level;
   
   import game.general.MapAnalyzer;
   
   
   public class BackgroundActor extends Actor
   {
      
      private var mBackground:Tiled2dBackgroundInstance;
      
      public function BackgroundActor (level:Level)
      {
         super (level);
      }
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_background2d)
         {
            var sprite2dFile:Sprite2dFile = Engine.GetDataAsset (appearanceDefine.mFilePath) as Sprite2dFile;
            mBackground = new Tiled2dBackgroundInstance (sprite2dFile, appearanceValue as int);
            mBackground.SetGridVisible (true);
            mBackground.SetGridColor (0xE0E0E0);
            mBackground.SetPresentRegion (null);
            addChild (mBackground);
               
            MapAnalyzer.SetMapInfo (mBackground.GetPhysicalInfoFromLayer (0));
         }
      }
      
      override public function Initialize ():void
      {
         mLevel.AddDisplayObject (Level.LayerID_Background, this);
      }
   }
}