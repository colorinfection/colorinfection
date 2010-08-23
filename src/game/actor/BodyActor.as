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
   
   public class BodyActor extends PhysicsActor
   {
      public function BodyActor (level:Level)
      {
         super (level);
      }
      
      protected var mPhysicsBody:b2Body;
      
      public function GetPhysicsBody ():b2Body
      {
         return mPhysicsBody;
      }
      
      public function RebuildDisplayShape ():void
      {
      }
      
      
   }
}