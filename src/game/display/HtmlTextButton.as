
package game.display {
   
   import flash.display.SimpleButton;
   import flash.display.Shape;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   

   

   
   public class HtmlTextButton extends SimpleButton 
   {
      public function HtmlTextButton (text:String, withBG:Boolean, cached:Boolean, 
                                      bgcolor:int=0xC0C080, bgcolorOver:int=0x80CC80, textcolor:int = 0x000000, bordercolor:int = 0x8080A0, 
                                      thickness:int = 1, radium:int = 8)
      {
         var infoBox1:DialogBox = new DialogBox ();
         infoBox1.SetText (text, true);
         infoBox1.SetBackgroundVisible (withBG);
         infoBox1.SetCached (cached);
         infoBox1.SetBackgroundColor (bgcolor);
         infoBox1.SetTextColor (textcolor);
         infoBox1.SetBorderColor (bordercolor);
         infoBox1.SetBorderThickness (thickness);
         infoBox1.SetRoundRadium (radium);
         
         infoBox1.alpha = 1;
         
         infoBox1.Rebuild ();
         
         upState = infoBox1;
         hitTestState = infoBox1;
         
         if (withBG)
         {
            var infoBox2:DialogBox = new DialogBox ();
            
            infoBox2.SetText (text, true);
            infoBox2.SetBackgroundVisible (withBG);
            infoBox2.SetCached (cached);
            infoBox2.SetBackgroundColor (bgcolorOver);
            infoBox2.SetTextColor (textcolor);
            infoBox2.SetBorderColor (bordercolor);
            infoBox2.SetBorderThickness (thickness);
            infoBox2.SetRoundRadium (radium);
            
            infoBox2.alpha = 1;
            
            infoBox2.Rebuild ();
            
            overState = infoBox2;
            downState = infoBox2;
         }
         else
         {
            overState = infoBox1;
            downState = infoBox1;
         }
      }
   }
   
}
   