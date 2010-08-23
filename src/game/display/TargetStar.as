
package game.display {
   
   import flash.display.Shape;
   
   public class TargetStar extends Shape
   {
      private var mRadiums:Number;
      private var mColor:int;
      
      public function TargetStar (radiums:Number)
      {
         mRadiums = radiums;
         
         mColor = -1;
         SetColor (0);
         
      }
      
      public function SetColor (color:int):void
      {
         if (mColor == color)
            return;
         
         mColor = color;
         
         graphics.clear ();
         /*
         graphics.lineStyle (1,color);
         graphics.moveTo ( -mRadiums, 0);
         graphics.lineTo (  mRadiums, 0);
         graphics.moveTo ( 0, -mRadiums);
         graphics.lineTo ( 0,  mRadiums);
         */
         
         graphics.beginFill(color);
         graphics.lineStyle(1, 0x0);
         graphics.drawRoundRect( -mRadiums, -2, mRadiums + mRadiums, 4, 1);
         graphics.drawRoundRect( -2, -mRadiums, 4, mRadiums + mRadiums, 1);
         graphics.endFill();
      }
      
      public function UpdateAnimation (dur:Number):void
      {
         //
         rotation += dur * 60;
      }
   }
}