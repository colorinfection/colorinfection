package game.actor {
   
   import flash.display.Shape;
   
   import engine.util.Helper;
   
   import game.res.kDefines;
   import game.res.kTemplate;
   
   
   import game.level.Level;
   
   import game.display.DialogBox;
   
   import game.Config;
   
   public class LevelConfigActor extends Actor
   {
      
      private var mLevelInfoText:DialogBox;
      
      public function LevelConfigActor (level:Level)
      {
         super (level);
      }
      
      override public function Initialize ():void
      {
         return;
         
         mLevel.AddDisplayObject (Level.LayerID_BackgroundSurface, this);
         
         //
         
         //
         mLevelInfoText = new DialogBox ();
         addChild (mLevelInfoText);
         
         var text:String = "";
         text += "<br>";
         text += "Level Name: " + mLevel.GetLevelName ();
         text += "<br>";
         text += "Hard Index : " + mLevel.GetLevelHardIndex ();
         text += "<br>";
         text += "Level Score: " + mLevel.GetLevelScore ();
         
         mLevelInfoText.SetText (text, true);
         mLevelInfoText.SetCached (false);
         mLevelInfoText.SetBackgroundVisible (false);
         mLevelInfoText.SetTextColor (0x0);
         
         mLevelInfoText.Rebuild ();
         
         mLevelInfoText.x = - mLevelInfoText.width  / 2;
         mLevelInfoText.y = - mLevelInfoText.height / 2;
      }
      
   }
}