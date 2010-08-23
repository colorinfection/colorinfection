package game {

   import game.Game;

	
	public class GameState implements GameEntity
	{
      protected var mGame:Game;
	
      public function GameState (game:Game)
      {
         mGame = game;
      }
		
		public function Initialize ():void
		{
		}
		
		public function Destroy ():void
		{
		}
		
		public function Update (escapedTime:Number):void
		{
		}
		
		//public function Render ():void
		//{
		//}


	
	}	
}