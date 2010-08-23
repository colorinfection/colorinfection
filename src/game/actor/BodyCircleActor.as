
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
   
   public class BodyCircleActor extends BodyActor
   {
      
      public function BodyCircleActor (level:Level)
      {
         super (level);
      }
      
      /*
      override protected function ResponseMouseDown ():void
      {
         if (mCustomProperties == null && mPhysicsBody != null)
         {
            mLevel.GetPhysicsWorld ().DestroyBody (mPhysicsBody);
            
            // to do: set mLevel.mActors [i] = null;
            visible = false;
         }
      }
      */
      
      private var mColor:uint;
      
      public var mRadius:uint = 2;
      public var mCenterX:uint = 0;
      public var mCenterY:uint = 0;
      
      private var mDisplayShape:Shape = null;
      
      override protected function LoadAppearance (appearanceID:int, appearanceDefine:Object, appearanceValue:Object):void
      {
         super.LoadAppearance (appearanceID, appearanceDefine, appearanceValue);
         
         if (appearanceDefine.mTypeID == kDefines.AppearanceType_circle)
         {
            var circle:Array = appearanceValue as Array;
            
            mRadius  = circle[0];
            mCenterX = circle[1];
            mCenterY = circle[2];
         }
      }
      
      override public function RebuildDisplayShape ():void
      {
         if (mDisplayShape == null)
         {
            mDisplayShape = new Shape ();
            mDisplayShape.x = mCenterX;
            mDisplayShape.y = mCenterY;
            addChild  (mDisplayShape);
         }
         
         //var r:Number = mCustomProperties == null ? mRadius / 2: mRadius;
         var r:Number = mRadius;
         
         var showBorder:Boolean = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Show_Border];
         var isStatic:Boolean = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Is_Static];
         showBorder = ! isStatic || showBorder;
         Helper.ClearAndDrawEllipse (mDisplayShape, - r, - r, r + r, r + r, showBorder ? 0 : mColor, showBorder ? 1 : 0, true, mColor);
         
         //
         var isColumn:Boolean = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Is_Column];
         
         //
         if (Level.IsColorBlindMode ())
         {
            var x1:Number;
            var y1:Number;
            var x2:Number;
            var y2:Number;
            var x3:Number;
            var y3:Number;
            var x4:Number;
            var y4:Number;
            
            if (mColor == Config.InfectedColor)
            {
               x1 = mRadius * Math.cos (0) * 2 / 3; y1 = mRadius * Math.sin (0) * 2 / 3;
               x2 = mRadius * Math.cos (Math.PI * 0.50) * 2 / 3; y2 = mRadius * Math.sin (Math.PI * 0.50) * 2 / 3;
               x3 = mRadius * Math.cos (Math.PI * 1.00) * 2 / 3; y3 = mRadius * Math.sin (Math.PI * 1.00) * 2 / 3;
               x4 = mRadius * Math.cos (Math.PI * 1.50) * 2 / 3; y4 = mRadius * Math.sin (Math.PI * 1.50) * 2 / 3;
               
               Helper.DrawLine (mDisplayShape, x1, y1, x2, y2, 0xFFFFCC, 1);
               Helper.DrawLine (mDisplayShape, x2, y2, x3, y3, 0xFFFFCC, 1);
               Helper.DrawLine (mDisplayShape, x3, y3, x4, y4, 0xFFFFCC, 1);
               Helper.DrawLine (mDisplayShape, x4, y4, x1, y1, 0xFFFFCC, 1);
            }
            else if (mColor == Config.BreakableColor)
            {
               x1 = mRadius * Math.cos (0); y1 = mRadius * Math.sin (0);
               x2 = mRadius * Math.cos (Math.PI * 0.50); y2 = mRadius * Math.sin (Math.PI * 0.50);
               x3 = mRadius * Math.cos (Math.PI * 1.00); y3 = mRadius * Math.sin (Math.PI * 1.00);
               x4 = mRadius * Math.cos (Math.PI * 1.50); y4 = mRadius * Math.sin (Math.PI * 1.50);
               
               Helper.DrawLine (mDisplayShape, 0, 0, x1, y1);
               Helper.DrawLine (mDisplayShape, 0, 0, x2, y2);
               Helper.DrawLine (mDisplayShape, 0, 0, x3, y3);
               Helper.DrawLine (mDisplayShape, 0, 0, x4, y4);
            }
            else if (mColor == Config.NotInfectedColor || mColor == Config.DontInfectColor)
            {
               x1 = mRadius * Math.cos (0)              ; y1 = mRadius * Math.sin (0)              ;
               x2 = mRadius * Math.cos (2 * Math.PI / 3); y2 = mRadius * Math.sin (2 * Math.PI / 3);
               x3 = mRadius * Math.cos (4 * Math.PI / 3); y3 = mRadius * Math.sin (4 * Math.PI / 3);
               
               if (mColor == Config.NotInfectedColor)
               {
                  Helper.DrawLine (mDisplayShape, x1, y1, x2, y2);
                  Helper.DrawLine (mDisplayShape, x2, y2, x3, y3);
                  Helper.DrawLine (mDisplayShape, x3, y3, x1, y1);
               }
               else
               {
                  Helper.DrawLine (mDisplayShape, 0, 0, x1, y1);
                  Helper.DrawLine (mDisplayShape, 0, 0, x2, y2);
                  Helper.DrawLine (mDisplayShape, 0, 0, x3, y3);
               }
            }
         }
         
         //
         var friction:Number =  mCustomProperties == null ? 0.1 : mCustomProperties [kTemplate.ICP_circle_Shape_Friction];
         if (! isStatic && friction > 0)
         {
            if (isColumn)
            {
              // r -= 3;
              // if (r > 0)
              //    Helper.DrawEllipse (mDisplayShape, - r, - r, r + r, r + r, 0, 1, false, mColor);
               
               Helper.DrawLine (mDisplayShape, 0, 0, r, 0);
            }
            else if (! Level.IsColorBlindMode ())
               Helper.DrawEllipse (mDisplayShape, r/2-1, r/2-1, 2, 2, 0, 1, true, mColor);
         }
      }
      
      override public function Initialize ():void
      {
         //
         var isStatic:Boolean = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Is_Static];
         
         var density:Number = mCustomProperties == null ? 8.0 : mCustomProperties [kTemplate.ICP_circle_Shape_Density]
         
         //
         var bodyDef:b2BodyDef = new b2BodyDef();
         bodyDef.position.Set(mLevel.Display2Physics (x), mLevel.Display2Physics (y));
         bodyDef.angle = rotation * (Math.PI / 180);
         bodyDef.isBullet = mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Is_Bullet];
         if (! mLevel.IsObjectDefaultBullet ())
            bodyDef.isBullet = false;
         
         trace ("bodyDef.isBullet = " + bodyDef.isBullet);
         
         mPhysicsBody = mLevel.GetPhysicsWorld ().CreateBody(bodyDef);
         
         // 
         var circleDef:b2CircleDef = new b2CircleDef ();
         
         circleDef.localPosition.Set(mLevel.Display2Physics (mCenterX), mLevel.Display2Physics (mCenterY));
         circleDef.radius = mLevel.Display2Physics (mRadius);
         circleDef.density = isStatic ? 0.0 : density;
         circleDef.friction =  mCustomProperties == null ? 0.1 : mCustomProperties [kTemplate.ICP_circle_Shape_Friction];
         circleDef.restitution = mCustomProperties == null ? 0.2 : mCustomProperties [kTemplate.ICP_circle_Shape_Restitution];
         circleDef.filter.groupIndex = mCustomProperties == null ? 0 : mCustomProperties [kTemplate.ICP_circle_Shape_Group_Index];
         
         circleDef.isSensor = false;// mCustomProperties == null ? true : false;
         
         
         var circleShape:b2Shape = mPhysicsBody.CreateShape (circleDef);
         mPhysicsBody.SetMassFromShapes();
         
         //
         circleShape.SetUserData (this);
         mPhysicsBody.SetUserData (this);
         
         //
         SetInfected (mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Is_Infected]);
         
      if (Compiler::debugging || IsVisible ())
      {
         mLevel.AddDisplayObject ( mColor == Config.StaticObjectColor ? Level.LayerID_Background : 
                                   ( IsInfected () || IsInfectedable () ? Level.LayerID_MovableActors2 : Level.LayerID_MovableActors)
                                   , this);
      }
      
      }
      
      override public function Destroy ():void
      {
      }
      
      override public function Update (escapedTime:Number):void
      {
         if ( ! IsInfected () && IsInfectedable () && ! DontInfect () || IsInfected () && DontInfect ())
         {
            mLevel.SetFinished (false);
         }
         
         var phyPos:b2Vec2 = mPhysicsBody.GetPosition();
         
         x = mLevel.Physics2Display (phyPos.x);
         y = mLevel.Physics2Display (phyPos.y);
         
         rotation = (mPhysicsBody.GetAngle() * (180/Math.PI)) % 360;
         
         //trace ("circle x = " + x + ", y = " + y);
      }
      
      override public function SetInfected (infected:Boolean):void
      {
         if (! infected && DontInfect ())
            mColor = Config.DontInfectColor;
         else if (IsInfected () || IsInfectedable ())
            mColor = infected ? Config.InfectedColor : Config.NotInfectedColor;
         else if (mPhysicsBody == null || mPhysicsBody.IsStatic ())
            mColor = Config.StaticObjectColor;
         else
            mColor = Config.MovingObjectColor;
         
         if (mModel == null || mModel.GetAnimationID () < 0)
            RebuildDisplayShape ();
      }
      
      override public function IsInfected ():Boolean
      {
         return mColor == Config.InfectedColor;
      }
      
      override public function IsInfectedable ():Boolean
      {
         return mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Is_Infectedable];
      }
      
      override public function DontInfect ():Boolean
      {
         return mCustomProperties == null ? false : mCustomProperties [kTemplate.ICP_circle_Dont_Infect_Me];
      }
      
      override public function NotifyPhysicsBodyDestroyed ():void
      {
         if (mDisplayShape != null)
         {
             removeChild  (mDisplayShape);
             
             trace ("remove circle.");
         }
      }
   }
}
