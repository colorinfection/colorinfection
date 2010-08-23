
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
   
   public class JointPrismaticActor extends JointActor
   {
      public function JointPrismaticActor (level:Level)
      {
         super (level);
      }
      
      
      private var mPrismaticJoint:b2PrismaticJoint;
      private var mRotationDiffWithBody1:Number;
      
      private var mDisplayShape:Shape = null;
      private var mDisplayShape2:Shape = null;
      
      public var mAnchorX1:int;
      public var mAnchorY1:int;
      public var mAnchorX2:int;
      public var mAnchorY2:int;
      
      
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
         
         x = mAnchorX1;
         y = mAnchorY1;
         
         var dx:Number = mAnchorX2 - mAnchorX1;
         var dy:Number = mAnchorY2 - mAnchorY1;
         rotation = Math.atan2 (dy, dx) * 180 / Math.PI;
         
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
         
         Helper.ClearAndDrawLine (mDisplayShape, 0, 0, length, 0, 0xffdddd, 1);
         
         if (mDisplayShape2 == null)
         {
            mDisplayShape2 = new Shape ();
            addChild (mDisplayShape2);
         }
         
         Helper.ClearAndDrawEllipse (mDisplayShape2, - 2, - 2, 4, 4, 0, 1, true, 0xff0000);
         

      }
      
      
      override public function Initialize ():void
      {
         RebuildDisplayShape ();
      if (Compiler::debugging)
      {
         mLevel.AddDisplayObject (Level.LayerID_MovableActors, this);
      }
         
         //
         var bodyActor1:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_prismatic_joint_Body_1]) as BodyActor;
         var bodyActor2:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_prismatic_joint_Body_2]) as BodyActor;
         
         //
         var body1:b2Body = bodyActor1 != null ? bodyActor1.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         var body2:b2Body = bodyActor2 != null ? bodyActor2.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         
         var anchor:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (x), mLevel.Display2Physics (y));
         var radians:Number = rotation * Math.PI / 180;
         var axis:b2Vec2 = new b2Vec2 (Math.cos (radians), Math.sin (radians));
         
         var jointDef:b2PrismaticJointDef = new b2PrismaticJointDef ();
         jointDef.Initialize(body1, body2, anchor, axis);
         
         jointDef.enableLimit      = mCustomProperties [kTemplate.ICP_prismatic_joint_Enable_Limit];
         jointDef.lowerTranslation = mLevel.Display2Physics (mCustomProperties [kTemplate.ICP_prismatic_joint_Lower_Translation]);
         jointDef.upperTranslation = mLevel.Display2Physics (mCustomProperties [kTemplate.ICP_prismatic_joint_Upper_Translation]);
         
         jointDef.enableMotor = mCustomProperties [kTemplate.ICP_prismatic_joint_Enable_Motor];
         jointDef.motorSpeed  = mLevel.Display2Physics (mCustomProperties [kTemplate.ICP_prismatic_joint_Motor_Speed]);
         jointDef.maxMotorForce = mCustomProperties [kTemplate.ICP_prismatic_joint_Max_Motor_Force];
         
         mPrismaticJoint = mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2PrismaticJoint;
         mRotationDiffWithBody1 = rotation - body1.GetAngle () * 180 / Math.PI;
         
         //trace (" > mRotationDiffWithBody1 = " + mRotationDiffWithBody1 + ", rotation = " + rotation + ", body1.GetAngle () * 180 / Math.PI = " + (body1.GetAngle () * 180 / Math.PI));
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         var anchor1:b2Vec2 = mPrismaticJoint.GetAnchor1();
         
         x = mLevel.Physics2Display (anchor1.x);
         y = mLevel.Physics2Display (anchor1.y);
         
         var body1:b2Body = mPrismaticJoint.GetBody1 ();
         rotation = mRotationDiffWithBody1 + body1.GetAngle () * 180 / Math.PI;
         
         //
         var translation:Number = mPrismaticJoint.GetJointTranslation ();
         var speed:Number = mPrismaticJoint.GetMotorSpeed ();
         if ( speed < 0 && translation < mPrismaticJoint.GetLowerLimit () 
           || speed > 0 && translation > mPrismaticJoint.GetUpperLimit () 
         )
         {
            mPrismaticJoint.SetMotorSpeed (-speed);
         }
         
         
         //trace ("x = " + x + ", y = " + y);
         
         //trace (" > mRotationDiffWithBody1 = " + mRotationDiffWithBody1 + ", rotation = " + rotation + ", body1.GetAngle () * 180 / Math.PI = " + (body1.GetAngle () * 180 / Math.PI));
      }
   }
}
