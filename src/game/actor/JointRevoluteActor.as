
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
   
   public class JointRevoluteActor extends JointActor
   {
      public function JointRevoluteActor (level:Level)
      {
         super (level);
      }
      
      
      private var mRevoluteJoint:b2RevoluteJoint;
      
      private var mDisplayShape:Shape = null;
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_circle)
         {
         }
         
      }
      
      
      public function RebuildDisplayShape ():void
      {
      
         if (mDisplayShape == null)
         {
            mDisplayShape = new Shape ();
            addChild  (mDisplayShape);
         }
      if (Compiler::debugging)
      {
         Helper.ClearAndDrawEllipse (mDisplayShape, -2, -2, 4, 4, 0, 1, true, 0xffff00);
      }
      else if (mCustomProperties [kTemplate.ICP_revolute_joint_Is_Visible])
      {
         Helper.ClearAndDrawEllipse (mDisplayShape, -1, -1, 2, 2, 0, 1, false, 0x0);
      }
      }
      
      override public function Initialize ():void
      {
         RebuildDisplayShape ();
         mLevel.AddDisplayObject (Level.LayerID_MovableActors2, this);
         
         //
         var bodyActor1:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_revolute_joint_Body_1]) as BodyActor;
         var bodyActor2:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_revolute_joint_Body_2]) as BodyActor;
         
         //
         var body1:b2Body = bodyActor1 != null ? bodyActor1.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         var body2:b2Body = bodyActor2 != null ? bodyActor2.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         
         var anchor:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (x), mLevel.Display2Physics (y));
         
         var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef ();
         jointDef.Initialize(body1, body2, anchor);
         
         jointDef.enableLimit = mCustomProperties [kTemplate.ICP_revolute_joint_Enable_Limit];
         jointDef.lowerAngle = mCustomProperties [kTemplate.ICP_revolute_joint_Lower_Angle] * Math.PI / 180;
         jointDef.upperAngle = mCustomProperties [kTemplate.ICP_revolute_joint_Upper_Angle] * Math.PI / 180;
         
         jointDef.enableMotor = mCustomProperties [kTemplate.ICP_revolute_joint_Enable_Motor];
         jointDef.motorSpeed = mCustomProperties [kTemplate.ICP_revolute_joint_Motor_Speed] * Math.PI / 180;
         jointDef.maxMotorTorque = mCustomProperties [kTemplate.ICP_revolute_joint_Max_Motor_Torque];
         
         
         
         mRevoluteJoint = mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2RevoluteJoint;
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         var anchor1:b2Vec2 = mRevoluteJoint.GetAnchor1();
         var anchor2:b2Vec2 = mRevoluteJoint.GetAnchor2();
         
         //rotation = 180 * Math.atan2 (anchor2.y - anchor1.y, anchor2.x - anchor1.x) / Math.PI;
         x = ( mLevel.Physics2Display (anchor2.x) + mLevel.Physics2Display (anchor1.x) ) / 2;
         y = ( mLevel.Physics2Display (anchor2.y) + mLevel.Physics2Display (anchor1.y) ) / 2;
         
         if (mRevoluteJoint.IsLimitEnabled ())
         {
            var angle:Number = mRevoluteJoint.GetJointAngle ();
            var speed:Number = mRevoluteJoint.GetMotorSpeed ();
            if ( speed < 0 && angle < mRevoluteJoint.GetLowerLimit () 
              || speed > 0 && angle > mRevoluteJoint.GetUpperLimit () 
            )
            {
               mRevoluteJoint.SetMotorSpeed (-speed);
            }
         }
      }
   }
}

