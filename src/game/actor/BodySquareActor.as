
package game.actor {
   
   import flash.display.Shape;
   
   import Box2D.Dynamics.*;
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
   
   import game.Config;
   
   public class BodySquareActor extends BodyActor
   {
      public function BodySquareActor (level:Level)
      {
         super (level);
      }
      
      private var mColor:uint;
      
      public var mLeft:int;
      public var mTop:int;
      public var mRight:int;
      public var mBottom:int;
      
      private var mDisplayShape:Shape = null;
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_box2d)
         {
            var box:Array = appearanceValue as Array;
            mLeft   = box[0];
            mTop    = box[1];
            mRight  = box[2];
            mBottom = box[3];
         }
      }
      
      override public function RebuildDisplayShape ():void
      {
      
         if (mDisplayShape == null)
         {
            mDisplayShape = new Shape ();
            //mDisplayShape.alpha = 0.8;
            addChild  (mDisplayShape);
         }
         
         if (mColor == Config.BreakableColor)
			alpha = 0.77;
         
         Helper.ClearAndDrawRect (mDisplayShape, mLeft, mTop, mRight - mLeft, mBottom - mTop, mColor == Config.StaticObjectColor ? mColor : 0, 1, true, mColor);
         
         //
         if (Level.IsColorBlindMode ())
         {
            var centerX:Number = (mLeft + mRight + 1) * 0.5;
            var centerY:Number = (mTop + mBottom + 1) * 0.5;
            
            if (mColor == Config.BreakableColor)
            {
               Helper.DrawLine (mDisplayShape, centerX, centerY, centerX, mTop);
               Helper.DrawLine (mDisplayShape, centerX, centerY, centerX, mBottom);
               Helper.DrawLine (mDisplayShape, centerX, centerY, mLeft, centerY);
               Helper.DrawLine (mDisplayShape, centerX, centerY, mRight, centerY);
            }
         }
      }
      
      override public function Initialize ():void
      {
         
         //
         
         //
         var isStatic:Boolean = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_square_Is_Static];
         
         //
         var bodyDef:b2BodyDef = new b2BodyDef();
         bodyDef.position.Set(mLevel.Display2Physics (x), mLevel.Display2Physics (y));
         bodyDef.angle = rotation * (Math.PI / 180);
         bodyDef.isSleeping = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_square_Is_Sleeping];
         bodyDef.isBullet = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_square_Is_Bullet];
         if (! mLevel.IsObjectDefaultBullet ())
            bodyDef.isBullet = false;
         
         mPhysicsBody = mLevel.GetPhysicsWorld ().CreateBody(bodyDef);
         
         // 
         var phyLeft:Number   = mLevel.Display2Physics (mLeft);
         var phyRight:Number  = mLevel.Display2Physics (mRight);
         var phyTop:Number    = mLevel.Display2Physics (mTop);
         var phyBottom:Number = mLevel.Display2Physics (mBottom);
         var boxHalfWidth:Number  = (phyRight - phyLeft) / 2;
         var boxHalfHeight:Number = (phyBottom - phyTop) / 2;
         var center:b2Vec2 =  new b2Vec2 ((phyRight + phyLeft) / 2, (phyBottom + phyTop) / 2);
         var boxDef:b2PolygonDef = new b2PolygonDef ();

         boxDef.SetAsOrientedBox (boxHalfWidth, boxHalfHeight, center, 0); //bodyDef.angle);
         //boxDef.SetAsBox (boxHalfWidth, boxHalfHeight);
         boxDef.density = isStatic ? 0.0 : 1.0;
         boxDef.friction = 0.1;
         boxDef.restitution = 0.2;
         boxDef.filter.groupIndex = mCustomProperties == null ? 0 : mCustomProperties [kTemplate.ICP_square_Shape_Group_Index];
         
         var squareShape:b2Shape = mPhysicsBody.CreateShape (boxDef);
         mPhysicsBody.SetMassFromShapes();
         
         //
         squareShape.SetUserData (this);
         mPhysicsBody.SetUserData (this);
         
         //
         SetBreakable (mCanBreakableNow);
         
      if (Compiler::debugging || IsVisible ())
      {
         mLevel.AddDisplayObject (mColor == Config.StaticObjectColor ? Level.LayerID_Background : Level.LayerID_MovableActors, this);
      }
         
         if (mLevel.IsBreakingByOrder ())
         {
            SetLinkedActorBreakable (false);
         }
      }
      
      public function SetLinkedActorBreakable (breakable:Boolean):void
      {
         if (mCustomProperties != null && mCustomProperties [kTemplate.ICP_square_Actor_Link] >= 0)
         {
            var linkedActor:Actor = mLevel.GetActorAt (mCustomProperties [kTemplate.ICP_square_Actor_Link]);
            if (linkedActor is PhysicsActor)
            {
               (linkedActor as PhysicsActor).SetBreakable (breakable);
            }
         }
      }
      
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         var phyPos:b2Vec2 = mPhysicsBody.GetPosition();
         
         x = mLevel.Physics2Display (phyPos.x);
         y = mLevel.Physics2Display (phyPos.y);
         
         
         //if (! mPhysicsBody.IsStatic ())
         //   trace ("angle =" + mPhysicsBody.GetAngle());
         
         rotation = (mPhysicsBody.GetAngle() * (180/Math.PI)) % 360;
         
         //trace ("square x = " + x + ", y = " + y);
      }
      
      /*
      override public function SetInfected (infected:Boolean):void
      {
         if (infected)
         if (mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_square_Is_Static])
            return;
         
         mColor = infected ? InfactedColor : 0xddddff;
         
         if (mModel == null || mModel.GetAnimationID () < 0)
            RebuildDisplayShape ();
      }
      
      override public function IsInfected ():Boolean
      {
         return mColor == InfactedColor;
      }
      */
      
      override public function IsInfectedable ():Boolean
      {
         return mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_square_Is_Infectedable];
      }
      
      private var mCanBreakableNow:Boolean = true;
      override public function SetBreakable (breakable:Boolean):void
      {
         mCanBreakableNow = breakable;
         
         if (mPhysicsBody == null)
            return; // not initialized
         
         if (mCustomProperties != null && mCustomProperties [kTemplate.ICP_square_Is_Breakable])
            mColor = IsBreakable () ? Config.BreakableColor : Config.NotBreakableColor;
         else if (mPhysicsBody.IsStatic ())
            mColor = Config.StaticObjectColor;
         else
            mColor = Config.MovingObjectColor;
         
         if (mModel == null || mModel.GetAnimationID () < 0)
            RebuildDisplayShape ();
      }
      
      override public function IsBreakable ():Boolean
      {
         return mCanBreakableNow && mCustomProperties != null && mCustomProperties [kTemplate.ICP_square_Is_Breakable];
      }
      
      override public function NotifyPhysicsBodyDestroyed ():void
      {
         if (mDisplayShape != null)
         {
             removeChild  (mDisplayShape);
             
             trace ("remove square.");
         }
      }
   }
}
