
package game.display {
   
   import flash.display.Sprite;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   import flash.display.Shape;
   import flash.display.PixelSnapping;
   
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   
   import flash.geom.Matrix;
   
   import game.GameEntity;
   
   public class DialogBox extends Sprite 
   {
      private var mIsCached:Boolean = false;
      
      private var mMessageText:String = "";
      private var mIsHtmlText:Boolean = false;
      
      private var mTextColor:int = 0x000000;
      
      private var mBackgroundVisible:Boolean = true;
      private var mBackgroundColor:int = 0xAAAADD;
      private var mBorderColor:int = 0x8080A0;
      
      private var mBorderThickness:int = 3;
      private var mRoundRadium:int = 8;
      
      private var mSpecifiedWidth:int = 0;
      
      //[Embed(source='C:\\Windows\\Fonts\\times.ttf', fontName="Time New Roman", mimeType="application/x-font-truetype")]
      //private static var TIMES_FONT:String;
      
      public function DialogBox ()
      {
      }
      
      public function Rebuild ():void
      {
         while (numChildren > 0)
            removeChildAt (0);
         
         // create text field
         var textField:TextField = new TextField ();

         textField.autoSize = TextFieldAutoSize.LEFT;
         textField.selectable = false;
         textField.background = mBackgroundVisible;
         textField.backgroundColor = mBackgroundColor;
         textField.textColor = mTextColor;
         textField.multiline = true;
         //mHelpText.wordWrap = true;
         if (mIsHtmlText)
            textField.htmlText = mMessageText;
         else
            textField.text = mMessageText;
         
         // create background
         var background:Shape = null;
         
         if (mBackgroundVisible)
         {
            background = new Shape ();
            
            var radium:uint = mRoundRadium; //8;
            var w:uint = textField.width + radium + radium;
            var h:uint = textField.height + radium + radium;

            background.graphics.beginFill(mBackgroundColor);
            background.graphics.lineStyle(mBorderThickness, mBorderColor);
            background.graphics.drawRoundRect(0, 0, w, h, mRoundRadium);
            background.graphics.endFill();
            
            //
            background.x = (mBorderThickness ) / 2;
            background.y = (mBorderThickness ) / 2;
            textField.x = mRoundRadium + (mBorderThickness ) / 2;
            textField.y = mRoundRadium + (mBorderThickness ) / 2;
         }
         
         //
         /*
         mIsCached = false;
         
         textField.embedFonts = true;
         
         var format:TextFormat = new TextFormat();
         format.font = TIMES_FONT;
         format.color = 0xFF0000;
         format.size = 10;
         //format.underline = true;

         textField.defaultTextFormat = format;
         */
         
         //
         
         if (! mIsCached)
         {
            if (mBackgroundVisible)
               addChild (background);
            
            addChild (textField);
         }
         else
         {
            var bitmapData:BitmapData;
            var matrix:Matrix = new Matrix ();
            
            if (mBackgroundVisible)
            {
               bitmapData = new BitmapData (background.width, background.height, true, 0x00FFFFFF);
               
               matrix.tx = background.x;
               matrix.ty = background.y;
               bitmapData.draw (background, matrix);
            }
            else
            {
               bitmapData = new BitmapData (textField.width, textField.height, true, 0x00FFFFFF);
            }
            
            matrix.tx = textField.x;
            matrix.ty = textField.y;
            bitmapData.draw (textField, matrix);
            
            var bitmap:Bitmap = new Bitmap (bitmapData);
            
            bitmap.smoothing = true;
            bitmap.pixelSnapping = PixelSnapping.AUTO;
            
            //bitmap.x = textField.x;
            //bitmap.y = textField.y;
            
            addChild (bitmap);
         }
      }
      
      public function SetCached (cached:Boolean):void
      {
         mIsCached = cached;
      }
      
      public function SetText (text:String, isHtml:Boolean = false):void
      {
         mMessageText = text;
         mIsHtmlText = isHtml;
      }
      
      public function SetTextColor (color:int):void
      {
         mTextColor = color;
      }
      
      public function SetBackgroundColor (color:int):void
      {
         mBackgroundColor = color;
      }
      
      public function SetBackgroundVisible (_visible:Boolean):void
      {
         mBackgroundVisible = _visible;
      }
      
      public function SetBorderColor (color:int):void
      {
         mBorderColor = color;
      }
      
      public function SetBorderThickness (thickness:int):void
      {
         if (thickness > 0)
            mBorderThickness = thickness;
      }
      
      public function SetRoundRadium (radium:int):void
      {
         if (radium >=0)
            mRoundRadium = radium;
      }
   }

}