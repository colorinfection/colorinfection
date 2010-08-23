
package game.level {

   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   
   import flash.utils.ByteArray;
   
   import flash.events.MouseEvent;
   
   import flash.utils.getTimer;
   
   import flash.geom.Matrix;
   
   import Box2D.Dynamics.*;
   import Box2D.Collision.*;
   import Box2D.Collision.Shapes.*;
   import Box2D.Common.Math.*;
   
   import game.display.*;
   
   import engine.Engine;
   import engine.asset.Sprite2dFile;
   import engine.display.Sprite2dModelInstance;
   import engine.display.Tiled2dBackgroundInstance;
   import engine.display.GameDisplayObject;
   
   import engine.asset.LevelDefine;
   import engine.asset.ActorDefine;
   
   import engine.asset.ActorTemplate;

   import game.res.kDefines;
   import game.res.kTemplate;
   
   import game.GameState;
   import game.GameEntity;

   import game.Game;
   import game.Config;

   import game.actor.Actor;
   import game.actor.LevelConfigActor;
   import game.actor.BackgroundActor;
   
   import game.actor.BodyActor;
   import game.actor.BodySquareActor;
   import game.actor.BodyCircleActor;
   import game.actor.BodyCompoundActor;
   
   import game.actor.PhysicsActor;
   
   import game.actor.JointActor;
   import game.actor.JointDistanceActor;
   import game.actor.JointRevoluteActor;
   import game.actor.JointPrismaticActor;
   import game.actor.JointPulleyActor;
   import game.actor.JointChainActor;
   
   import game.KeyInput;
   
   import game.state.GameState_Level;
   
   import game.physics.ContactListener;
   import game.physics.DestructionListener;
   
       
   public class Level extends Sprite implements GameEntity
   {
      public var mActors:Array;
      public var mActorsCount:int;
      
      public var mDynamicActors:Array;
      public var mDynamicActorsCount:int;
      
      
      private var mPlayfieldWidth:uint;
      private var mPlayfieldHeight:uint;
      
      private var mLevelConfigActor:LevelConfigActor;
      
      private static var sCurrentLevel:Level = null;
      
      
      public static var sIsColorBlindMode:Boolean = false;
      
      public function Level ()
      {
         sCurrentLevel = this;
         CreateDisplayLayers ();
      }
      
      public static function IsColorBlindMode ():Boolean
      {
         return sIsColorBlindMode;
      }
      
      public static function SetColorBlindMode (colorBlind:Boolean):void
      {
         if (sIsColorBlindMode != colorBlind)
         {
            sIsColorBlindMode = colorBlind;
            
            if (sCurrentLevel != null)
               sCurrentLevel.RebuildDisplayShapeOfAllBodies ();
         }
      }
      
      public function RebuildDisplayShapeOfAllBodies ():void
      {
         for (var actorID:int = 0; actorID < mActorsCount; ++ actorID)
         {
            var actor:BodyActor = mActors [actorID] as BodyActor;
            
            if (actor != null)
               if (actor is BodyCircleActor || actor is BodySquareActor)
                  actor.RebuildDisplayShape ();
         }
      }
      
      public function GetPlayfieldWidth ():uint
      {
         return mPlayfieldWidth;
      }
      
      public function GetPlayfieldHeight ():uint
      {
         return mPlayfieldHeight;
      }
      
      public function GetLevelName ():String
      {
         return mLevelConfigActor == null ? Config.kGameName + " Level" : mLevelConfigActor.mCustomProperties [kTemplate.ICP_level_config_Level_Name];
      }
      
      public function GetLevelScore ():int
      {
         return mLevelConfigActor == null ? 1 : mLevelConfigActor.mCustomProperties [kTemplate.ICP_level_config_Level_Score];
      }
      
      public function GetLevelHardIndex ():int
      {
         return mLevelConfigActor == null ? 1 : mLevelConfigActor.mCustomProperties [kTemplate.ICP_level_config_Hard_Index];
      }
      
      public function IsBreakingByOrder ():Boolean
      {
         return mLevelConfigActor == null ? true : mLevelConfigActor.mCustomProperties [kTemplate.ICP_level_config_Break_By_Order];
      }
      
      public function IsObjectDefaultBullet ():Boolean
      {
         return mLevelConfigActor == null ? true : mLevelConfigActor.mCustomProperties [kTemplate.ICP_level_config_Default_Bullet];
      }
      
      public function GetActorAt (index:int):Actor
      {
         if (index >= 0 && index < mActors.length)
         {
            return mActors [index];
         }
         
         return null;
      }
      
      
      public function Load (levelFilePath:String, dataSrc:ByteArray):void
      {
         //
         CreatePhysicsWorld ();
         
         //
         var levelDefine:LevelDefine = new LevelDefine (levelFilePath);
         levelDefine.Load (dataSrc);
         
         //
         mPlayfieldWidth  = levelDefine.mPlayfieldWidth;
         mPlayfieldHeight = levelDefine.mPlayfieldHeight;
         
         //
         var actorDefines:Array = levelDefine.mActorDefines;
         mActorsCount = actorDefines.length;
         mActors = new Array (mActorsCount);
         
         
         for (var actorID:int=0; actorID < mActorsCount; ++ actorID)
         {
            var actorDefine:ActorDefine      = actorDefines [actorID];
            
            trace ("actor id = " + actorID + ", actorDefine = " + actorDefine);
            
            var actorTemplate:ActorTemplate  = actorDefine.mTemplate;
            var instanceType:int             = actorTemplate.mInstanceActorType;
            
            if (instanceType != kDefines.ActorType_general)
               continue;
            
            var templateID:int = actorTemplate.mTemplateID;
            
            var actor:Actor = null;
            
            switch (templateID)
            {
               case kTemplate.TemplateID_level_config:
                  actor = new LevelConfigActor (this);
                  mLevelConfigActor = actor as LevelConfigActor;
                  break;
               case kTemplate.TemplateID_square:
                  actor = new BodySquareActor (this);
                  break;
               case kTemplate.TemplateID_circle:
                  actor = new BodyCircleActor (this);
                  break;
               case kTemplate.TemplateID_compound_a:
               case kTemplate.TemplateID_compound_b:
               case kTemplate.TemplateID_compound_c:
                  actor = new BodyCompoundActor (this);
                  break;
               case kTemplate.TemplateID_distance_joint:
                  actor = new JointDistanceActor (this);
                  break;
               case kTemplate.TemplateID_revolute_joint:
                  actor = new JointRevoluteActor (this);
                  break;
               case kTemplate.TemplateID_prismatic_joint:
                  actor = new JointPrismaticActor (this);
                  break;
               case kTemplate.TemplateID_pulley_joint:
                  actor = new JointPulleyActor (this);
                  break;
               case kTemplate.TemplateID_chain_joint:
                  actor = new JointChainActor (this);
                  break;
               default:
                  break;
            }
            
            mActors [actorID] = actor;
            
            if (actor != null)
            {
               actor.SetIndex (actorID);
               
               //addChild (actor);
               
               actor.LoadFromDefine (actorDefine);
            }
            
         }
         
         //
         mDynamicActors = new Array (1000);
         mDynamicActorsCount = 0;
      }
      
      public function AddDynamicActor (actor:Actor):void
      {
         mDynamicActors [mDynamicActorsCount ++] = actor;
      }
      
      public function Initialize ():void
      {
         var actorID:int;
         var actor:Actor;
         
         for (actorID = 0; actorID < mActorsCount; ++ actorID)
         {
            actor = mActors [actorID] as Actor;
            
            if (actor != null && actor is BodyActor)
               actor.Initialize ();
         }
         
         for (actorID = 0; actorID < mActorsCount; ++ actorID)
         {
            actor = mActors [actorID] as Actor;
            
            if (actor != null && actor is JointActor)
               actor.Initialize ();
         }
         
         for (actorID = 0; actorID < mActorsCount; ++ actorID)
         {
            actor = mActors [actorID] as Actor;
            
            if (actor != null && ! (actor is PhysicsActor) )
               actor.Initialize ();
         }
         
         //
         LevelStatusInfo.ClearLevelHistoryInfos ();
         
         // wired? to make key event receiveable after entering levels
         stage.focus = this;
         stage.focus = null;
         
         //
         addEventListener (MouseEvent.MOUSE_DOWN, OnMouseDown);
         addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
         addEventListener(MouseEvent.MOUSE_MOVE , OnMouseMove);
      }
      
      public function Destroy ():void
      {
         for (var actorID:int = 0; actorID < mActorsCount; ++ actorID)
         {
            var actor:Actor = mActors [actorID] as Actor;
            
            if (actor != null)
               actor.Destroy ();
         }
         
         for (var dynamicActorID:int = 0; dynamicActorID < mDynamicActorsCount; ++ dynamicActorID)
         {
            var dynamicActor:Actor = mDynamicActors [dynamicActorID];
            
            if (dynamicActor != null)
               dynamicActor.Destroy ();
         }
      }
      
      public function Update (escapedTime:Number):void
      {
         SetFinished (true);
         
         UpdatePhysicsWorld (escapedTime);
         
         for (var actorID:int = 0; actorID < mActorsCount; ++ actorID)
         {
            var actor:Actor = mActors [actorID] as Actor;
            
            if (actor != null)
               actor.Update (escapedTime);
         }
         
         for (var dynamicActorID:int = 0; dynamicActorID < mDynamicActorsCount; ++ dynamicActorID)
         {
            var dynamicActor:Actor = mDynamicActors [dynamicActorID];
            
            if (dynamicActor != null)
               dynamicActor.Update (escapedTime);
         }
      }
      
      private var mFinished:Boolean = false;
      public function IsFinished ():Boolean
      {
         return mFinished;
      }
      
      public function SetFinished (finished:Boolean):void
      {
         mFinished = finished;
      }
      
      
//==========================================================================================
// layers 
//==========================================================================================
      
      public static var   _LayerID:uint = 0;
      public static const LayerID_Background:uint = _LayerID ++;
      public static const LayerID_BackgroundSurface:uint = _LayerID ++;
      public static const LayerID_TutorialActors:uint = _LayerID ++;
      public static const LayerID_StaticActors:uint = _LayerID ++;
      public static const LayerID_MovableActors:uint = _LayerID ++;
      public static const LayerID_MovableActors2:uint = _LayerID ++;
      public static const LayersCount:uint = _LayerID ++;
      
      private function CreateDisplayLayers ():void
      {
         for (var layerID:uint = 0; layerID < LayersCount; ++ layerID)
            addChild (new Sprite ());
      }
      
      public function AddDisplayObject (layerID:uint, object:DisplayObject):void
      {
         trace ("level: add object, layerID = " + layerID + ", object = " + object);
         
         var layer:Sprite = getChildAt (layerID) as Sprite;
         
         if (layer != null)
         {
            layer.addChild (object);
         }
      }
      
      public function RemoveDisplayObject (layerID:uint, object:DisplayObject):void
      {
         trace ("level: remove object, layerID = " + layerID + ", object = " + object);
         
         var layer:Sprite = getChildAt (layerID) as Sprite;
         
         if (layer != null)
         {
            layer.removeChild (object);
         }
      }
      
      
      
//==========================================================================================
// physics
//==========================================================================================

      private var mDisplay2PhysicsScale:Number = 0.10;
      private var mPhysics2DisplayScale:Number = 1.0 / mDisplay2PhysicsScale;
      
      public function Display2Physics (dv:Number):Number
      {
         return dv * mDisplay2PhysicsScale;
      }
      
      public function Physics2Display (pv:Number):Number
      {
         return pv * mPhysics2DisplayScale;
      }
      
      public function _DisplayPoint2PhysicsPoint (dp:Point):void
      {
         dp.x = Display2Physics (dp.x);
         dp.y = Display2Physics (dp.y);
      }
      
      public function _PhysicsPoint2DisplayPoint (pp:Point):void
      {
         pp.x = Physics2Display (pp.x);
         pp.y = Physics2Display (pp.y);
      }
      
      
      public function DisplayPoint2PhysicsPoint (dp:Point):Point
      {
         var pp:Point = new Point ();
         pp.x = dp.x;
         pp.y = dp.y;
         _DisplayPoint2PhysicsPoint (pp);
         return pp;
      }
      
      public function PhysicsPoint2DisplayPoint (pp:Point):Point
      {
         var dp:Point = new Point ();
         dp.x = pp.x;
         dp.y = pp.y;
         _PhysicsPoint2DisplayPoint (dp);
         return dp;
      }
      
      // ...
      private var mPhysicsTimerScale:Number = 1.0;
      public function SetPhysicsTimeScale (scale:Number):void
      {
         if (Config.kSupportTimeScale)
         {
            if (scale < 0) scale = 0;
            if (scale > 10) scale = 10;
            mPhysicsTimerScale = scale;
         }
      }
      
      public function GetPhysicsTimeScale ():Number
      {
         return mPhysicsTimerScale;
      }
      
      public static function SetPhysicsSimulationTimeScale (scale:Number):void
      {
         if (sCurrentLevel != null)
            sCurrentLevel.SetPhysicsTimeScale (scale);
      }
      
      public function SetPhysicsTimeSpeedUp (speedup:Boolean):void
      {
         SetPhysicsTimeScale (speedup? 2.0 : 1.0);
      }
      
      
      private var mPhysicsWorld:b2World;
      private var m_iterations:int = 50;
      
      //private var mContactListener:ContactListener;
      
      public function GetPhysicsWorld ():b2World
      {
         return mPhysicsWorld;
      }
      
      
      
      private function CreatePhysicsWorld ():void
      {
         
         // Creat world AABB
         var worldAABB:b2AABB = new b2AABB();
         worldAABB.lowerBound.Set(-1000.0, -1000.0);
         worldAABB.upperBound.Set(1000.0, 1000.0);
         
         // Define the gravity vector
         var gravity:b2Vec2 = new b2Vec2(0.0, 9.8 * 2);
         
         // Allow bodies to sleep
         var doSleep:Boolean = true;
         
         // Construct a world object
         mPhysicsWorld = new b2World(worldAABB, gravity, doSleep);
         
         mPhysicsWorld.SetContactListener(new ContactListener ());
         mPhysicsWorld.SetDestructionListener(new DestructionListener ());
      }
      
      
      private var mLastFrameTime:Number;
      private var mSteps:int = 0;
      public function UpdatePhysicsWorld (escapedTime:Number):void
      {
         mSteps ++;
         /*
         if (mSteps % 100 == 99)
         {
            mPhysicsWorld.SetGravity (new b2Vec2(0.0, -9.8 / 5));
            
         
            for (var actorID:int = 0; actorID < mActorsCount; ++ actorID)
            {
               var actor:Actor = mActors [actorID] as Actor;
               
               if (actor != null && actor is BodyActor)
                  (actor as BodyActor).GetPhysicsBody ().WakeUp ();
            }
         
         }
         */
         
         
         if (escapedTime > 0.05)
            escapedTime = 0.05;
         
         //
         //escapedTime = 1.0 / stage.frameRate;
         //escapedTime *= 1.5;
         
         // 
         var time1:Number = getTimer ();
         
         //
         /*
         if (mPhysicsTimerScale >= 1)
         {
            var loops:int = mPhysicsTimerScale;
            for (var i:int = 0; i < loops; ++ i)
            {
               mPhysicsWorld.Step(escapedTime, m_iterations);
            }
         }
         else
         {
            var realEscapedTime:Number = escapedTime * mPhysicsTimerScale;
            var realIterations:int     = m_iterations; // * mPhysicsTimerScale;
            
            mPhysicsWorld.Step(realEscapedTime, realIterations);
         }
         */
         
         var scale2:Number = mPhysicsTimerScale * 2;
         var escapedTime2:Number = escapedTime * 0.5;
         
         if (scale2 >= 1)
         {
            var loops:int = scale2;
            for (var i:int = 0; i < loops; ++ i)
            {
               mPhysicsWorld.Step(escapedTime2, m_iterations);
            }
         }
         else
         {
            var realEscapedTime:Number = escapedTime * mPhysicsTimerScale;
            var realIterations:int     = m_iterations; // * mPhysicsTimerScale;
            
            mPhysicsWorld.Step(realEscapedTime, realIterations);
         }
         
         
         //mPhysicsWorld.Validate ();
         
         var time2:Number = getTimer ();
         
         //trace (" -----------------------------------------  Step time = " + (time2 - time1));
      }
      
      
      
      protected function OnMouseDown (e:MouseEvent):void
      {
         // rewrite this function to make sure it is not called when mPhysicsWorld is stepping
         
         //
         if (mPhysicsWorld == null)
            return;
         
         var levelMartix:Matrix = transform.concatenatedMatrix; // matrix relative to stage
         levelMartix.invert ();
         
         var stagePoint:Point = new Point (KeyInput.mMouseStageX, KeyInput.mMouseStageY);
         //var levelPoint:Point = levelMartix.transformPoint (stagePoint);
         var levelPoint:Point = globalToLocal (stagePoint);
         
         var p:b2Vec2 = new b2Vec2 ();
         p.Set(Display2Physics (levelPoint.x), Display2Physics(levelPoint.y));
         
         var aabb:b2AABB = new b2AABB ();
         var d:b2Vec2 = new b2Vec2 ();
         d.Set(Display2Physics (6.0), Display2Physics (6.0));
         aabb.lowerBound.Set (p.x - d.x, p.y - d.y);
         aabb.upperBound.Set (p.x + d.x, p.y + d.y);
         
         var maxCount:uint = 16;
         var shapes:Array = new Array (maxCount); 
         
         var somebodiesDestroyed:Boolean = false;
         
         var count:int = mPhysicsWorld.Query(aabb, shapes, maxCount);
         
         for (var i:int = 0; i < count; ++ i)
         {
            var shapeBody:b2Body = shapes[i].GetBody();
            
            //if (shapeBody->IsStatic() == false && shapeBody->GetMass() > 0.0f)
            {
               var userdata:Object = shapeBody.GetUserData ();
               if (userdata is PhysicsActor && ! (userdata as PhysicsActor).IsBreakable () )
                  continue;
               
               var inside:Boolean = shapes[i].TestPoint(shapeBody.GetXForm(), p);
               if (inside)
               {
               /*
                  if (shapeBody.m_shapeCount > 1)
                  {
                     shapeBody.DestroyShape (shapes[i]);
                     
                     if (userdata != null && userdata is PhysicsActor)
                        (userdata as PhysicsActor).NotifyPhysicsShapeDestroyed (shapes[i]);
                  }
                  else
               */
                  {
                     mPhysicsWorld.DestroyBody (shapeBody);
                     
                     if (userdata != null && userdata is PhysicsActor)
                     {
                        (userdata as PhysicsActor).NotifyPhysicsBodyDestroyed ();
                        
                        somebodiesDestroyed = true;
                        
                        if (userdata is BodySquareActor)
                        {
                           (userdata as BodySquareActor).SetLinkedActorBreakable (true);
                        }
                        else if (userdata is BodyCompoundActor)
                        {
                           (userdata as BodyCompoundActor).SetLinkedActorBreakable (true);
                        }
                     }
                  }
               }
            }
            
         }
         
        // SetPhysicsTimeSpeedUp ( ! somebodiesDestroyed );
      }
      
      protected function OnMouseUp (e:MouseEvent):void
      {
         // SetPhysicsTimeSpeedUp (false);
      }
      
      protected function OnMouseMove (e:MouseEvent):void
      {
        // SetPhysicsTimeSpeedUp (e.buttonDown);
      }
      

      
   }
}
