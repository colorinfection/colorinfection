package engine.display {

   import flash.display.Sprite;
    
   public class GameDisplayObject extends Sprite 
   {
      private var _z:Number;
      
      public function GameDisplayObject ()
      {
         
      }
      
      public function get z():Number
      {
         return _z;
      }
      
      public function set z(value:Number):void 
      {
         _z = value;
      }

   }
}