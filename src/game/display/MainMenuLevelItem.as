
package game.display {
   
   import flash.display.SimpleButton;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Sprite2dModelInstance;
   
   import game.level.Level;
   
   public class MainMenuLevelItem extends SimpleButton 
   {
      private static const AnimID_Finished:int = 7;
      private static const AnimID_Locked  :int = 8;
      
      
      private var mLevelIndex:uint;
      
      
      
      public function MainMenuLevelItem (levelIndex:uint, finished:Boolean, locked:Boolean, w:uint, h:uint) 
      {
         mLevelIndex = levelIndex;
         
         
         //
    //     var sprite2dFile:Sprite2dFile = Engine.GetDataAsset ("misc.xSprite2d") as Sprite2dFile; 
    //     var icon:Sprite2dModelInstance;
         
         // Create the different states of the button, using the
         // helper method to create different colors circles
         upState = new Sprite ();
         
         (upState as Sprite).addChild (CreateRoundRect( finished ? 0x60C060 : 0xC06060, w, h, Level.IsColorBlindMode () && finished ));
    /*
         if (finished)
         {
            icon = new Sprite2dModelInstance (sprite2dFile, 0);
            icon.SetAnimationID (AnimID_Finished);
            icon.x = (w - icon.width) / 2;
            icon.y = (h - icon.height) / 2;
            (upState as Sprite).addChild (icon);
         }
         if (locked)
         {
            icon = new Sprite2dModelInstance (sprite2dFile, 0);
            icon.SetAnimationID (AnimID_Locked);
            icon.x = (w - icon.width) / 2;
            icon.y = (h - icon.height) / 2;
            (upState as Sprite).addChild (icon);
         }
    */
         
         
         overState = new Sprite ();
         
         (overState as Sprite).addChild (CreateRoundRect( 0x8080FF, w, h, Level.IsColorBlindMode () && finished ));
    /*
         if (finished)
         {
            icon = new Sprite2dModelInstance (sprite2dFile, 0);
            icon.SetAnimationID (AnimID_Finished);
            icon.x = (w - icon.width) / 2;
            icon.y = (h - icon.height) / 2;
            (overState as Sprite).addChild (icon);
         }
         if (locked)
         {
            icon = new Sprite2dModelInstance (sprite2dFile, 0);
            icon.SetAnimationID (AnimID_Locked);
            icon.x = (w - icon.width) / 2;
            icon.y = (h - icon.height) / 2;
            (overState as Sprite).addChild (icon);
         }
     */

         
         downState = overState;
         hitTestState = upState;
      }
      
      public function GetLevelIndex ():uint
      {
         return mLevelIndex;
      }
      
      // Helper function to create a circle shape with a given color
      // and radius
      private function CreateRoundRect( color:uint, w:Number, h:Number, drawColorBlindCircle:Boolean = false):Shape 
      {
         var block:Shape = new Shape();
         block.graphics.beginFill(color);
         block.graphics.lineStyle(2, 0xB0B0B0);
         block.graphics.drawRoundRect(0, 0, w, h, 8);
         block.graphics.endFill();
         
         if (drawColorBlindCircle)
         {
          block.graphics.lineStyle(1, 0x0);
            block.graphics.drawEllipse(w * 0.25, h * 0.25, w * 0.5, h * 0.5);
         }
         
         return block;
      }
      

   }
}