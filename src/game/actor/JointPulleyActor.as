
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
   
   public class JointPulleyActor extends JointActor
   {
      public function JointPulleyActor (level:Level)
      {
         super (level);
      }
      
      public var mGroundAnchorX1:int;
      public var mGroundAnchorY1:int;
      public var mGroundAnchorX2:int;
      public var mGroundAnchorY2:int;
      
      public var mAnchorX1:int;
      public var mAnchorY1:int;
      public var mAnchorX2:int;
      public var mAnchorY2:int;
      
      private var mPulleyJoint:b2PulleyJoint;
      
      private var mDisplayShape:Shape = null;
      private var mDisplayShape2:Shape = null;
      private var mDisplayShape3:Shape = null;

      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_line2d)
         {
            var line:Array;
            
            if (appearanceID == kTemplate. Appearance_pulley_joint_segment_1)
            {
               line = appearanceValue as Array;
               mGroundAnchorX1 = line[0];
               mGroundAnchorY1 = line[1];
               mAnchorX1 = line[2];
               mAnchorY1 = line[3];
            }
            else if (appearanceID == kTemplate. Appearance_pulley_joint_segment_2)
            {
               line = appearanceValue as Array;
               mGroundAnchorX2 = line[0];
               mGroundAnchorY2 = line[1];
               mAnchorX2 = line[2];
               mAnchorY2 = line[3];
            }
            
         }
      }
      
      
      public function RebuildDisplayShape ():void
      {
         var radians:Number = rotation * Math.PI / 180;
         
         var ax:Number = mGroundAnchorX1;
         var ay:Number = mGroundAnchorY1;
         mGroundAnchorX1 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mGroundAnchorY1 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         ax = mGroundAnchorX2;
         ay = mGroundAnchorY2;
         mGroundAnchorX2 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mGroundAnchorY2 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         ax = mAnchorX1;
         ay = mAnchorY1;
         mAnchorX1 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY1 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         ax = mAnchorX2;
         ay = mAnchorY2;
         mAnchorX2 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY2 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         
         x = (mGroundAnchorX2 + mGroundAnchorX1) / 2;
         y = (mGroundAnchorY2 + mGroundAnchorY1) / 2;
         
         rotation = 0;
         
         //mGroundAnchorX1 = mGroundAnchorX1 - x;
         //mGroundAnchorY1 = mGroundAnchorY1 - y;
         //mGroundAnchorX2 = mGroundAnchorX2 - x;
         //mGroundAnchorY2 = mGroundAnchorY2 - y;
         
         
         //
      }
      
      public function RebuildBodyDisplayObjects ():void
      {
         var anchor1:b2Vec2 = mPulleyJoint.GetAnchor1();
         var anchor2:b2Vec2 = mPulleyJoint.GetAnchor2();
         var groundAnchor1:b2Vec2 = mPulleyJoint.GetGroundAnchor1();
         var groundAnchor2:b2Vec2 = mPulleyJoint.GetGroundAnchor2();
         
         mAnchorX1 = mLevel.Physics2Display (anchor1.x) - x;
         mAnchorY1 = mLevel.Physics2Display (anchor1.y) - y;
         mAnchorX2 = mLevel.Physics2Display (anchor2.x) - x;
         mAnchorY2 = mLevel.Physics2Display (anchor2.y) - y;
         
         mGroundAnchorX1 = mLevel.Physics2Display (groundAnchor1.x) - x;
         mGroundAnchorY1 = mLevel.Physics2Display (groundAnchor1.y) - y;
         mGroundAnchorX2 = mLevel.Physics2Display (groundAnchor2.x) - x;
         mGroundAnchorY2 = mLevel.Physics2Display (groundAnchor2.y) - y;
         
         
         // 
         var dy:Number = mGroundAnchorY2 - mGroundAnchorY1;
         var dx:Number = mGroundAnchorX2 - mGroundAnchorX1;
         
         var length:Number = Math.sqrt (dy * dy + dx * dx);
         
      //if (Compiler::debugging)
      //{
         if (mDisplayShape == null)
         {
            mDisplayShape = new Shape ();
      if (Compiler::debugging)
      {
            addChild  (mDisplayShape);
      }
         }
         
         Helper.ClearAndDrawLine (mDisplayShape, mGroundAnchorX1, mGroundAnchorY1, mGroundAnchorX2, mGroundAnchorY2, 0xffff00, 2);
      //}
         
         //
         if (mDisplayShape2 == null)
         {
            mDisplayShape2 = new Shape ();
            addChild (mDisplayShape2);
         }
         
         var dx1:Number = mAnchorX1 - mGroundAnchorX1;
         var dy1:Number = mAnchorY1 - mGroundAnchorY1;
         var dx2:Number = mAnchorX2 - mGroundAnchorX2;
         var dy2:Number = mAnchorY2 - mGroundAnchorY2;
         //trace ("length1 + length2 = " + (Math.sqrt (dx1 * dx1 + dy1 * dy1) + Math.sqrt (dx2 * dx2 + dy2 * dy2)));
         
         //trace ("mGroundAnchorX1 = " + mGroundAnchorX1 + ", mGroundAnchorY1 = " + mGroundAnchorY1 + ", mGroundAnchorX2 = " + mGroundAnchorX2 + ", mGroundAnchorY2 = " + mGroundAnchorY2);
         //trace ("mAnchorX1 = " + mAnchorX1 + ", mAnchorY1 = " + mAnchorY1 + ", mAnchorX2 = " + mAnchorX2 + ", mAnchorY2 = " + mAnchorY2);
         
         //mDisplayShape2.graphics.clear ();
         
         Helper.ClearShape (mDisplayShape2);
         Helper.DrawLine (mDisplayShape2, mAnchorX1, mAnchorY1, mGroundAnchorX1, mGroundAnchorY1);
         Helper.DrawLine (mDisplayShape2, mAnchorX2, mAnchorY2, mGroundAnchorX2, mGroundAnchorY2);
         
         //mDisplayShape2.graphics.lineStyle(1, 0x0);
         //mDisplayShape2.graphics.moveTo ( mAnchorX1, mAnchorY1 );
         //mDisplayShape2.graphics.lineTo ( mAnchorX2, mAnchorY2 );
         
         /*
         Helper.DrawRect (mDisplayShape2, 
                          mAnchorX1 < mAnchorX2 ? mAnchorX1 : mAnchorX2, 
                          mAnchorY1 < mAnchorY2 ? mAnchorY1 : mAnchorY2, 
                          mAnchorX1 < mAnchorX2 ? mAnchorX2 - mAnchorX1 : mAnchorX1 - mAnchorX2, 
                          mAnchorY1 < mAnchorY2 ? mAnchorY2 - mAnchorY1 : mAnchorY1 - mAnchorY2, 
                          0, 1, true, 0xff0000);
         */
         
         //trace ("mDisplayShape2.width = " + mDisplayShape2.width + ", mDisplayShape2.height = " + mDisplayShape2.height);

         // if merge shape3 and shape2, bug .... ??/ !!!
         if (mDisplayShape3 == null)
         {
            mDisplayShape3 = new Shape ();
            addChild (mDisplayShape3);
         }
         
         Helper.ClearShape (mDisplayShape3);
         Helper.DrawEllipse (mDisplayShape3, mAnchorX1 - 2, mAnchorY1 - 2, 4, 4, 0, 1, true, 0xff0000);
         Helper.DrawEllipse (mDisplayShape3, mAnchorX2 - 2, mAnchorY2 - 2, 4, 4, 0, 1, true, 0x00ff00);
         
      if (Compiler::debugging)
      {
         Helper.DrawEllipse (mDisplayShape3, mGroundAnchorX1 - 2, mGroundAnchorY1 - 2, 4, 4, 0, 1, true, 0xff0000);
         Helper.DrawEllipse (mDisplayShape3, mGroundAnchorX2 - 2, mGroundAnchorY2 - 2, 4, 4, 0, 1, true, 0x00ff00);
      }
      }
      
      override public function Initialize ():void
      {
         RebuildDisplayShape ();
         mLevel.AddDisplayObject (Level.LayerID_MovableActors, this);
         
         //
         var bodyActor1:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_pulley_joint_Body_1]) as BodyActor;
         var bodyActor2:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_pulley_joint_Body_2]) as BodyActor;
         
         //
         var body1:b2Body = bodyActor1 != null ? bodyActor1.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         var body2:b2Body = bodyActor2 != null ? bodyActor2.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         
         var groundAnchor1:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (mGroundAnchorX1), mLevel.Display2Physics (mGroundAnchorY1));
         var groundAnchor2:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (mGroundAnchorX2), mLevel.Display2Physics (mGroundAnchorY2));
         
         var anchor1:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (mAnchorX1), mLevel.Display2Physics (mAnchorY1));
         var anchor2:b2Vec2 = new b2Vec2 (mLevel.Display2Physics (mAnchorX2), mLevel.Display2Physics (mAnchorY2));
         
         var jointDef:b2PulleyJointDef = new b2PulleyJointDef ();
         jointDef.Initialize(body1, body2, groundAnchor1, groundAnchor2, anchor1, anchor2, 1.0);
         
         mPulleyJoint = mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2PulleyJoint;
         
         RebuildBodyDisplayObjects ();
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         RebuildBodyDisplayObjects ();
      }
   }
}
