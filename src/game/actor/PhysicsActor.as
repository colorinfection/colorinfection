
package game.actor {
   
   import flash.events.MouseEvent;
   
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
   
   public class PhysicsActor extends ModelActor
   {
      
      public function PhysicsActor (level:Level)
      {
         super (level);
         
         addEventListener (MouseEvent.MOUSE_DOWN, OnMouseDown);
      }
      
      protected function OnMouseDown (event:MouseEvent):void
      {
         /*
         //if (Rolledable ())
         {
            if (! KeyInput.sIsDeactived)
            {
               event.stopPropagation();
               event.stopImmediatePropagation();
            }
         }
         */
         
         ResponseMouseDown ();
      }
      
      protected function ResponseMouseDown ():void
      {
         
      }
      
      public function SetInfected (infected:Boolean):void
      {
         
      }
      
      public function IsInfected ():Boolean
      {
         return false;
      }
      
      public function IsInfectedable ():Boolean
      {
         return false;
      }
      
      public function DontInfect ():Boolean
      {
         return false;
      }
      
      public function SetBreakable (breakable:Boolean):void
      {
      }
      
      public function IsBreakable ():Boolean
      {
         if (Compiler::debugging)
            return true;
         else
            return false;
      }
      
      public function IsVisible ():Boolean
      {
         return mCustomProperties == null ? true : mCustomProperties [kTemplate.ICP_square_Is_Visible];
      }
      
      virtual public function NotifyPhysicsBodyDestroyed (/*body:b2Body*/):void
      {
         
      }
      
      virtual public function NotifyPhysicsShapeDestroyed (shape:b2Shape):void
      {
         
      }
      
      virtual public function NotifyPhysicsJointDestroyed (/*joint:b2Joint*/):void
      {
         
      }
   }
}


