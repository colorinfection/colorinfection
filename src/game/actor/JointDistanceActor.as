
package game.actor {
   
   import flash.display.Shape;
   
   import Box2D.Dynamics.*;
   import Box2D.Dynamics.Joints.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.Math.*;
   
   import engine.Engine;
   
   import engine.asset.Sprite2dFile;
   import engine.display.Sprite2dModelInstance;
   
   import engine.util.Helper;
   
   import game.res.kDefines;
   import game.res.kTemplate;
 
   
   import game.level.Level;
   
   public class JointDistanceActor extends JointActor
   {
      public function JointDistanceActor (level:Level)
      {
         super (level);
      }
      
      public var mAnchorX1:int;
      public var mAnchorY1:int;
      public var mAnchorX2:int;
      public var mAnchorY2:int;
      
      private var mDistanceJoint:b2DistanceJoint;
      
      private var mDisplayShape:Shape = null;
      private var mDisplayShape2:Shape = null;
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_line2d)
         {
            var line:Array = appearanceValue as Array;
            
            mAnchorX1 = line[0];
            mAnchorY1 = line[1];
            mAnchorX2 = line[2];
            mAnchorY2 = line[3];
         }
      }
      
      /*
      override protected function ResponseMouseDown ():void
      {
         if (mDistanceJoint != null)
         {
            var body1:b2Body = mDistanceJoint.GetBody1 ();
            var body2:b2Body = mDistanceJoint.GetBody2 ();
            body1.WakeUp ();
            body2.WakeUp ();
            mLevel.GetPhysicsWorld ().DestroyJoint (mDistanceJoint);
            
            // to do: set mLevel.mActors [i] = null;
            visible = false;
         }
      }
      */
      
      public function RebuildDisplayShape ():void
      {
            
         //
         var radians:Number = rotation * Math.PI / 180;
         
         var ax:Number = mAnchorX1;
         var ay:Number = mAnchorY1;
         mAnchorX1 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY1 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         ax = mAnchorX2;
         ay = mAnchorY2;
         mAnchorX2 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY2 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         
         x = (mAnchorX2 + mAnchorX1) / 2;
         y = (mAnchorY2 + mAnchorY1) / 2;
         
         var dx:Number = mAnchorX2 - mAnchorX1;
         var dy:Number = mAnchorY2 - mAnchorY1;
         rotation = Math.atan2 (dy, dx) * 180 / Math.PI;
         
         if (mCustomProperties [kTemplate.ICP_distance_joint_Is_Visible])
         {
         
            //
            var length:Number = Math.sqrt (dx * dx + dy * dy);
            
            // 
            if (mDisplayShape == null)
            {
               mDisplayShape = new Shape ();
               //mDisplayShape.x = (mAnchorX2 - mAnchorX1) / 2;
               //mDisplayShape.y = (mAnchorY2 + mAnchorY1) / 2;
               addChild  (mDisplayShape);
            }
            
            Helper.ClearAndDrawLine (mDisplayShape, -length/2, 0, length/2, 0, 0x0, 1);
            
            if (mCustomProperties [kTemplate.ICP_distance_joint_Show_Points])
            {
               if (mDisplayShape2 == null)
               {
                  mDisplayShape2 = new Shape ();
                  addChild (mDisplayShape2);
               }
                        
               Helper.ClearAndDrawEllipse (mDisplayShape2, -length/2, -2, 4, 4, 0, 1, true, 0xff0000);
               Helper.DrawEllipse (mDisplayShape2, length/2, -2, 4, 4, 0, 1, true, 0x00ff00);
            }
         }
      }
      
      override public function Initialize ():void
      {
         RebuildDisplayShape ();
         mLevel.AddDisplayObject (Level.LayerID_MovableActors, this);
         
         //
         var bodyActor1:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_distance_joint_Body_1]) as BodyActor;
         var bodyActor2:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_distance_joint_Body_2]) as BodyActor;
         
         //
         var body1:b2Body = bodyActor1 != null ? bodyActor1.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         var body2:b2Body = bodyActor2 != null ? bodyActor2.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         
         var anchor1:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (mAnchorX1), mLevel.Display2Physics (mAnchorY1));
         var anchor2:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (mAnchorX2), mLevel.Display2Physics (mAnchorY2));
         
         var jointDef:b2DistanceJointDef = new b2DistanceJointDef ();
         jointDef.Initialize(body1, body2, anchor1, anchor2);
         jointDef.collideConnected = true;
         
         mDistanceJoint = mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2DistanceJoint;
         
         mDistanceJoint.SetUserData (this);
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         var anchor1:b2Vec2 = mDistanceJoint.GetAnchor1();
         var anchor2:b2Vec2 = mDistanceJoint.GetAnchor2();
         
         rotation = 180 * Math.atan2 (anchor2.y - anchor1.y, anchor2.x - anchor1.x) / Math.PI;
         x = ( mLevel.Physics2Display (anchor2.x) + mLevel.Physics2Display (anchor1.x) ) / 2;
         y = ( mLevel.Physics2Display (anchor2.y) + mLevel.Physics2Display (anchor1.y) ) / 2;
         
      }
      
      override public function NotifyPhysicsJointDestroyed (/*joint:b2Joint*/):void
      {
         while (numChildren > 0)
            removeChildAt (0);
      }
   }
}
