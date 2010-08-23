package game.actor {
   
   import Box2D.Dynamics.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.Math.*;
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Sprite2dModelInstance;
   
   import game.res.kDefines;
   import game.res.kTemplate;
 
   
   import game.level.Level;
   
   public class JointActor extends PhysicsActor
   {
      public function JointActor (level:Level)
      {
         super (level);
      }
      
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
      }
      
      override public function Initialize ():void
      {
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
      }
      
   }
}