
package game.display {
   
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.SimpleButton;
   import flash.display.Shape;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   

   

   
   public class ImageButton extends SimpleButton 
   {
      private var mBitmap:Bitmap;
      
      public function ImageButton (bitmapData:BitmapData)
      {
         mBitmap = new Bitmap (bitmapData);
         
         upState = mBitmap;
         hitTestState = mBitmap;
         overState = mBitmap;
         downState = mBitmap;
      }
   }
   
}
   