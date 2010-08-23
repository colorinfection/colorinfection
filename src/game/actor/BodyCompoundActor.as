
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
   
   public class BodyCompoundActor extends BodyActor
   {
      public function BodyCompoundActor (level:Level)
      {
         super (level);
      }
      
      private var mColor:uint;
      
      public var mShapeParams:Array = new Array ();
      
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         var shapeParam:Object = new Object ();
         shapeParam.type = appearanceDefine.mTypeID;
         shapeParam.values = appearanceValue;
         mShapeParams [mShapeParams.length] = shapeParam;
      }
      
      override public function RebuildDisplayShape ():void
      {
         while (numChildren > 0)
            removeChildAt (0);
         
         // 
         if ( ! IsVisible () )
            return;
         
         for (var shapeID:int = 0; shapeID < mShapeParams.length; ++ shapeID)
         {
            var shapeParam:Object = mShapeParams [shapeID];
            if (shapeParam == null)
               continue;
            
            if (shapeParam.type == kDefines.AppearanceType_box2d)
            {
               
               var box:Array = shapeParam.values as Array;
               
               if (box[0] == 0 && box[1] == 0 && box[2] == 0 && box[3] == 0)
                  continue;
               
               // display
               var rectShape:Shape = new Shape ();
               //rectShape.alpha = 0.8;
               addChild  (rectShape);
               
               Helper.ClearAndDrawRect (rectShape, box[0], box[1], box[2] - box[0], box[3] - box[1], mColor == Config.StaticObjectColor ? mColor : 0, 1, true, mColor);
            }
            else if (shapeParam.type == kDefines.AppearanceType_circle)
            {
               var circle:Array = shapeParam.values as Array;
               
               if (circle[0] == 0)
                  continue;
               
               // display
               var circleShape:Shape = new Shape ();
               circleShape.x = circle[1];
               circleShape.y = circle[2];
               addChild  (circleShape);
               
               Helper.ClearAndDrawEllipse (circleShape, -circle[0], -circle[0], circle[0] + circle[0], circle[0] + circle[0], mColor == Config.StaticObjectColor ? mColor : 0, 1, true, mColor);
            }
         }
      }
      
      override public function Initialize ():void
      {
         
         
         //
         var isStatic:Boolean = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_compound_a_Is_Static];
         
         //
         var bodyDef:b2BodyDef = new b2BodyDef();
         bodyDef.position.Set(mLevel.Display2Physics (x), mLevel.Display2Physics (y));
         bodyDef.angle = rotation * (Math.PI / 180);
         bodyDef.isBullet =  mCustomProperties == null ? true : mCustomProperties [kTemplate.ICP_compound_a_Is_Bullet];
         if (! mLevel.IsObjectDefaultBullet ())
            bodyDef.isBullet = false;
         
         trace ("bodyDef.isBullet = " + bodyDef.isBullet);
         
         mPhysicsBody = mLevel.GetPhysicsWorld ().CreateBody(bodyDef);
         
         // 
         for (var shapeID:int = 0; shapeID < mShapeParams.length; ++ shapeID)
         {
            var shapeParam:Object = mShapeParams [shapeID];
            
            var phyShape:b2Shape = null;
            
            if (shapeParam.type == kDefines.AppearanceType_box2d)
            {
               
               var box:Array = shapeParam.values as Array;
               
               if (box[0] == 0 && box[1] == 0 && box[2] == 0 && box[3] == 0)
                  continue;
               
               // physics
               var phyLeft:Number   = mLevel.Display2Physics (box[0]);
               var phyRight:Number  = mLevel.Display2Physics (box[2]);
               var phyTop:Number    = mLevel.Display2Physics (box[1]);
               var phyBottom:Number = mLevel.Display2Physics (box[3]);
               var boxHalfWidth:Number  = (phyRight - phyLeft) / 2;
               var boxHalfHeight:Number = (phyBottom - phyTop) / 2;
               var center:b2Vec2 =  new b2Vec2 ((phyRight + phyLeft) / 2, (phyBottom + phyTop) / 2);
               var boxDef:b2PolygonDef = new b2PolygonDef ();

               boxDef.SetAsOrientedBox (boxHalfWidth, boxHalfHeight, center, 0); //bodyDef.angle);
               //boxDef.SetAsBox (boxHalfWidth, boxHalfHeight);
               boxDef.density = isStatic ? 0.0 : 1.0;
               boxDef.friction = 0.5;
               boxDef.restitution = 0.2;
               boxDef.filter.groupIndex = mCustomProperties == null ? 0 : mCustomProperties [kTemplate.ICP_compound_a_Shape_Group_Index];
               
               phyShape = mPhysicsBody.CreateShape (boxDef);
            }
            else if (shapeParam.type == kDefines.AppearanceType_circle)
            {
               var circle:Array = shapeParam.values as Array;
               
               if (circle[0] == 0)
                  continue;
               
               // physics
               var circleDef:b2CircleDef = new b2CircleDef (); 
               
               circleDef.localPosition.Set(mLevel.Display2Physics (circle[1]), mLevel.Display2Physics (circle[2]));
               circleDef.radius = mLevel.Display2Physics (circle[0]);
               circleDef.density = isStatic ? 0.0 : 1.0;
               circleDef.friction = 0.5;
               circleDef.restitution = 0.2;
               circleDef.filter.groupIndex = mCustomProperties == null ? 0 : mCustomProperties [kTemplate.ICP_compound_a_Shape_Group_Index];
               
               phyShape = mPhysicsBody.CreateShape (circleDef);
            }
            
            if (phyShape != null)
               phyShape.SetUserData (shapeID);
         }
         
         mPhysicsBody.SetMassFromShapes();
         
         //
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
         
         rotation = (mPhysicsBody.GetAngle() * (180/Math.PI)) % 360;
         
         //trace ("compound x = " + x + ", y = " + y);
      }
      
      private var mCanBreakableNow:Boolean = true;
      override public function SetBreakable (breakable:Boolean):void
      {
         mCanBreakableNow = breakable;
         
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
         return mCanBreakableNow && mCustomProperties != null && mCustomProperties [kTemplate.ICP_compound_a_Is_Breakable];
      }
      
      override public function NotifyPhysicsShapeDestroyed (shape:b2Shape):void
      {
         var shapeID:int = shape.GetUserData ();
         
         mShapeParams [shapeID] = null;
         
         RebuildDisplayShape ();
      }
      
      override public function NotifyPhysicsBodyDestroyed ():void
      {
         while (numChildren > 0)
         {
             removeChildAt  (0);
         }
      }
   }
}
