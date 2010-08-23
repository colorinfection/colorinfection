package engine.util {
   
   import flash.display.Shape;
   import flash.display.Graphics;
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Tiled2dBackgroundInstance;
   import engine.display.Sprite2dModelInstance;
   
   public class Helper 
   {
      
      public static function CreateTiled2dBackgroundInstance (appearanceDefine:Object, appearanceValue:Object):Tiled2dBackgroundInstance
      {
         var sprite2dFile:Sprite2dFile = Engine.GetDataAsset (appearanceDefine.mFilePath) as Sprite2dFile;
         return new Tiled2dBackgroundInstance (sprite2dFile, appearanceValue as int);
      }
      
      public static function CreateSprite2dModelInstance (appearanceDefine:Object, appearanceValue:Object):Sprite2dModelInstance
      {
         var sprite2dFile:Sprite2dFile = Engine.GetDataAsset (appearanceDefine.mFilePath) as Sprite2dFile;
         var model:Sprite2dModelInstance = new Sprite2dModelInstance (sprite2dFile, appearanceDefine.mModelID as int);
         
         model.SetAnimationID (appearanceValue as int);
         
         return model;
      }
      
      public static function CreateRectShape (x:int, y:int, w:uint, h:uint, borderColor:uint, borderSize:uint = 1, filled:Boolean = false, fillColor:uint = 0xFFFFFF):Shape
      {
         var rect:Shape = new Shape();
         if (filled) rect.graphics.beginFill(fillColor);
         rect.graphics.lineStyle(borderSize, borderColor);
         rect.graphics.drawRect(x, y, w, h);
         if (filled) rect.graphics.endFill();
         
         return rect;
      }
      
      public static function CreateEllipseShape (x:int, y:int, w:uint, h:uint, borderColor:uint, borderSize:uint = 1, filled:Boolean = false, fillColor:uint = 0xFFFFFF):Shape
      {
         var rect:Shape = new Shape();
         if (filled) rect.graphics.beginFill(fillColor);
         rect.graphics.lineStyle(borderSize, borderColor);
         rect.graphics.drawEllipse(x, y, w, h);
         if (filled) rect.graphics.endFill();
         
         return rect;
      }
      
      public static function ClearShape (shape:Shape):void
      {
         shape.graphics.clear ();
      }
      
      public static function ClearAndDrawRect (shape:Shape, x:int, y:int, w:uint, h:uint, borderColor:uint, borderSize:uint = 1, filled:Boolean = false, fillColor:uint = 0xFFFFFF):void
      {
         shape.graphics.clear ();
         if (filled) shape.graphics.beginFill(fillColor);
         shape.graphics.lineStyle(borderSize, borderColor);
         shape.graphics.drawRect(x, y, w, h);
         if (filled) shape.graphics.endFill();
      }
      
      public static function DrawEllipse (shape:Shape, x:int, y:int, w:uint, h:uint, borderColor:uint, borderSize:uint = 1, filled:Boolean = false, fillColor:uint = 0xFFFFFF):void
      {
         if (filled) shape.graphics.beginFill(fillColor);
         shape.graphics.lineStyle(borderSize, borderColor);
         shape.graphics.drawEllipse(x, y, w, h);
         if (filled) shape.graphics.endFill();
      }
      
      public static function DrawRect (shape:Shape, x:int, y:int, w:uint, h:uint, borderColor:uint, borderSize:uint = 1, filled:Boolean = false, fillColor:uint = 0xFFFFFF):void
      {
         if (filled) shape.graphics.beginFill(fillColor);
         shape.graphics.lineStyle(borderSize, borderColor);
         shape.graphics.drawRect(x, y, w, h);
         if (filled) shape.graphics.endFill();
      }
      
      public static function ClearAndDrawEllipse (shape:Shape, x:int, y:int, w:uint, h:uint, borderColor:uint, borderSize:uint = 1, filled:Boolean = false, fillColor:uint = 0xFFFFFF):void
      {
         shape.graphics.clear ();
         if (filled) shape.graphics.beginFill(fillColor);
         shape.graphics.lineStyle(borderSize, borderColor);
         shape.graphics.drawEllipse(x, y, w, h);
         if (filled) shape.graphics.endFill();
      }
      
      public static function ClearAndDrawLine (shape:Shape, x1:int, y1:int, x2:int, y2:int, color:uint = 0x0, thickness:uint = 1):void
      {
         shape.graphics.clear ();
         shape.graphics.lineStyle(thickness, color);
         shape.graphics.moveTo(x1, y1);
         shape.graphics.lineTo(x2, y2);
      }
      
      public static function DrawLine (shape:Shape, x1:int, y1:int, x2:int, y2:int, color:uint = 0x0, thickness:uint = 1):void
      {
         //trace ("x1 = " + x1 + ", y1 = " + y1 + ", x2= " + x2 + ", y2 = " + y2 + ", thickness = " + thickness);
         
         shape.graphics.lineStyle(thickness, color);
         shape.graphics.moveTo(x1, y1);
         shape.graphics.lineTo(x2, y2);
      }
   }
}