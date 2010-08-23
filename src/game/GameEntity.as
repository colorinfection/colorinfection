package game {


   public interface GameEntity
   {
      
      
      function Initialize ():void;
      
      function Destroy ():void;
      
      function Update (escapedTime:Number):void;
      


   }
}