
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
   
   public class JointChainActor extends JointActor
   {
      public function JointChainActor (level:Level)
      {
         super (level);
      }
      
      
      //private var mRevoluteJoints:Array;
      //private var mPhysicsBodies:Array;
      //private var mDisplayShapes:Array;
      
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
         var radians:Number = rotation * Math.PI / 180;
         
         var ax:Number = mAnchorX1;
         var ay:Number = mAnchorY1;
         mAnchorX1 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY1 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         ax = mAnchorX2;
         ay = mAnchorY2;
         mAnchorX2 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY2 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
      }
      
      override public function Initialize ():void
      {
         RebuildDisplayShape ();
         mLevel.AddDisplayObject (Level.LayerID_MovableActors, this);
         
         //
         var bodyActor1:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_chain_joint_Body_1]) as BodyActor;
         var bodyActor2:BodyActor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_chain_joint_Body_2]) as BodyActor;
         
         //
         var startBody:b2Body = bodyActor1 != null ? bodyActor1.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         var endBody:b2Body = bodyActor2 != null ? bodyActor2.GetPhysicsBody () : mLevel.GetPhysicsWorld ().GetGroundBody ();
         
         //
         /*
         var radians:Number = rotation * Math.PI / 180;
         
         var ax:Number = mAnchorX1;
         var ay:Number = mAnchorY1;
         mAnchorX1 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY1 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         ax = mAnchorX2;
         ay = mAnchorY2;
         mAnchorX2 = x + Math.cos (radians) * ax - Math.sin (radians) * ay;
         mAnchorY2 = y + Math.sin (radians) * ax + Math.cos (radians) * ay;
         */
         
         var dx:Number = mAnchorX2 - mAnchorX1;
         var dy:Number = mAnchorY2 - mAnchorY1;
         
         var length:Number = Math.sqrt (dx * dx + dy * dy);
         
         var ratio:Number = mCustomProperties [kTemplate.ICP_chain_joint_length_ratio];
         if (ratio < 1)
            ratio = 1;
         var segmentSize:Number = mCustomProperties [kTemplate.ICP_chain_joint_segment_size];

         if (segmentSize < 2)
            segmentSize = 2;
         var numSegments:uint = (length * ratio) / segmentSize;
         
         
         if (numSegments != 0)
         {
            dx = dx / numSegments;
            dy = dy / numSegments;
         }
         
         var jointDef:b2RevoluteJointDef;
         //var jointDef:b2DistanceJointDef;
         
         var anchor:b2Vec2 = new b2Vec2 ();
         anchor.x = mLevel.Display2Physics (mAnchorX1 + dx / 2);
         anchor.y = mLevel.Display2Physics (mAnchorY1 + dy / 2);
         
         var body:b2Body = startBody;
         var bodyX:Number = mAnchorX1 + dx;
         var bodyY:Number = mAnchorY1 + dy;
         for (var i:int = 0; i < numSegments - 1; ++ i)
         {
            var circleActor:BodyCircleActor = new BodyCircleActor (mLevel);
            mLevel.AddDynamicActor (circleActor);
            circleActor.x = bodyX;
            circleActor.y = bodyY;
            circleActor.mRadius = segmentSize / 2;
            circleActor.Initialize ();
            
            
            jointDef = new b2RevoluteJointDef ();
            jointDef.collideConnected = (i == 0 ? true : false);
            jointDef.Initialize(body, circleActor.GetPhysicsBody (), anchor);
            mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2RevoluteJoint;
            
            
            /*
            jointDef = new b2DistanceJointDef ();
            jointDef.dampingRatio = 1.0;
            jointDef.collideConnected = true; //false;
            if (i == 0)
            {
               jointDef.Initialize(body, circleActor.GetPhysicsBody (), 
                                   new b2Vec2 (mLevel.Display2Physics (mAnchorX1), mLevel.Display2Physics (mAnchorY1)), 
                                   circleActor.GetPhysicsBody ().GetPosition ());
               
               trace ("jointDef.length = " + jointDef.length);
            }
            else
               jointDef.Initialize(body, circleActor.GetPhysicsBody (), body.GetPosition (), circleActor.GetPhysicsBody ().GetPosition ());
            jointDef.Initialize(body, circleActor.GetPhysicsBody (), body.GetPosition (), circleActor.GetPhysicsBody ().GetPosition ());
            mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2DistanceJointDef;
            */
            
            bodyX += dx;
            bodyY += dy;
            anchor.x += mLevel.Display2Physics (dx);
            anchor.y += mLevel.Display2Physics (dy);
            body = circleActor.GetPhysicsBody ();
         }
         
         
         jointDef = new b2RevoluteJointDef ();
         jointDef.collideConnected = true; //false;
         jointDef.Initialize(body, endBody, anchor);         
         mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2RevoluteJoint;
         
         /*
         jointDef = new b2DistanceJointDef ();
         jointDef.dampingRatio = 1.0;
         jointDef.collideConnected = true; //false;
         if (numSegments <= 1)
         {
            jointDef.Initialize(body, endBody, 
                                new b2Vec2 (mLevel.Display2Physics (mAnchorX1), mLevel.Display2Physics (mAnchorY1)), 
                                endBody.GetPosition ());
         }
         else
            jointDef.Initialize(body, endBody, body.GetPosition (), endBody.GetPosition ());
         mLevel.GetPhysicsWorld ().CreateJoint (jointDef) as b2DistanceJointDef;
         */
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         
      }
   }
}
