
package game.physics {

   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Dynamics.Contacts.*;
   import Box2D.Dynamics.*;
   import Box2D.Common.Math.*;
   import Box2D.Common.*;

   import Box2D.Dynamics.b2ContactListener;
   
   import game.actor.PhysicsActor;
   
   public class ContactListener extends b2ContactListener
   {
   
      public function ContactListener ()
      {
      }
      
      /// Called when a contact point is added. This includes the geometry
      /// and the forces.
      override public function Add(point:b2ContactPoint) : void
      {
         var shape1:b2Shape = point.shape1;
         var shape2:b2Shape = point.shape2;
         var userdata1:Object = shape1.GetUserData ();
         var userdata2:Object = shape2.GetUserData ();
         
         if (userdata1 is PhysicsActor && userdata2 is PhysicsActor)
         {
            if ( (userdata1 as PhysicsActor).IsInfected () && ! (userdata2 as PhysicsActor).IsInfected () && (userdata2 as PhysicsActor).IsInfectedable ())
            {
               (userdata2 as PhysicsActor).SetInfected (true);
            }
            
            if ( (userdata2 as PhysicsActor).IsInfected () && ! (userdata1 as PhysicsActor).IsInfected () && (userdata1 as PhysicsActor).IsInfectedable ())
            {
               (userdata1 as PhysicsActor).SetInfected (true);
            }
         }
      }
      
      /// Called when a contact point persists. This includes the geometry
      /// and the forces.
      override public function Persist(point:b2ContactPoint) : void
      {
         Add (point);
      }
      
      /// Called when a contact point is removed. This includes the last
      /// computed geometry and forces.
      override public function Remove(point:b2ContactPoint) : void
      {
      }
      
      /// Called after a contact point is solved.
      override public function Result(point:b2ContactResult) : void
      {
      }
   }
 }

