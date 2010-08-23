
package game.physics {

   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Dynamics.Contacts.*;
   import Box2D.Dynamics.Joints.*;
   import Box2D.Dynamics.*;
   import Box2D.Common.Math.*;
   import Box2D.Common.*;

   import Box2D.Dynamics.b2DestructionListener;
   
   import game.actor.PhysicsActor;
   
   public class DestructionListener extends b2DestructionListener
   {
   
      public function DestructionListener ()
      {
      }
      
      /// Called when any joint is about to be destroyed due
      /// to the destruction of one of its attached bodies.
      override public virtual function SayGoodbyeJoint(joint:b2Joint) : void
      {
         var userdata:Object = joint.GetUserData ();
         
         if (userdata is PhysicsActor)
         {
            (userdata as PhysicsActor).NotifyPhysicsJointDestroyed ();
         }
      }
      
      /// Called when any shape is about to be destroyed due
      /// to the destruction of its parent body.
      override public virtual function SayGoodbyeShape(shape:b2Shape) : void
      {
      }

   }
 }

