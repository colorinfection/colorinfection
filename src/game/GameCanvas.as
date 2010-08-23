
package game {

   //import mx.core.UIComponent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.FocusEvent;
   
   
   import flash.utils.Timer;
   import flash.events.TimerEvent;  
   import flash.utils.getTimer;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.system.System;
   
   import flash.display.StageScaleMode;
   
   import engine.Engine;
   
   
   
   public dynamic class GameCanvas extends Sprite // UIComponent  
   {
      
      private var mGame:Game;
      
      public function GameCanvas ()
      {
         //
         addEventListener(Event.ADDED_TO_STAGE , OnAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE, OnRemovedFromStage);
         
         //
    //     stage.scaleMode = StageScaleMode.SHOW_ALL;
    //     stage.addEventListener(Event.RESIZE, OnStageResized);
      }
      
        private function OnStageResized(event:Event):void 
        {
            trace("resizeHandler: " + event);
            trace("stageWidth: " + stage.stageWidth + " stageHeight:  " + stage.stageHeight);
        }
      
      private function OnAddedToStage (e:Event):void 
      {
         // 
         Engine.SetTopObjectUrl (stage.loaderInfo.url);
         
         OnlineAPI.Initialize (stage);
         
         
         if (mGame == null)
         {
            mGame = new Game ();
            addChild (mGame);
         }
         

         // 
         addEventListener (Event.RESIZE, OnResize);
         addEventListener(Event.ENTER_FRAME, OnTimerTick);
         
         // keyboard
         stage.focus = stage;
         stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyInput.OnKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP, KeyInput.OnKeyUp);
         stage.addEventListener(Event.DEACTIVATE  , KeyInput.OnDeactivate);
         stage.addEventListener(Event.ACTIVATE  , KeyInput.OnActivate);
         //stage.addEventListener(FocusEvent.FOCUS_IN, KeyInput.OnFocusIn);
         //stage.addEventListener(FocusEvent.FOCUS_OUT  , KeyInput.OnFocusOut);
         
         // mouse 
         stage.addEventListener(MouseEvent.MOUSE_DOWN, KeyInput.OnMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP, KeyInput.OnMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_MOVE, KeyInput.OnMouseMove);
         //stage.addEventListener(MouseEvent.MOUSE_OUT, KeyInput.OnMouseOut);
         
         
         // disabled for AS3 bug
         //stage.addEventListener(MouseEvent.MOUSE_WHEEL, KeyInput.OnMouseWheel, false, 10000);
         
         //stage.addEventListener (MouseEvent.CLICK, KeyInput.OnMouseClick);
      }

      private function OnRemovedFromStage (e:Event):void 
      {
         //SetFrameRate (0);
      }     
      

      private function OnResize (event:Event):void 
      {
         //event.updateAfterEvent(); // not defined !
         stage.invalidate ();
      }

      //private static var mTimer:Timer;

      //public function SetFrameRate (frameRate:uint):void
      //{
         //if ( frameRate == 0 )
         //{
            //if ( mTimer != null )
            //{
               //mTimer.removeEventListener (TimerEvent.TIMER, OnTimerTick);
               //mTimer = null;
               
               //trace ("Timer stopped.");
            //}
         //}
         //else
         //{
            //SetFrameRate (0);
            
            //mTimer = new Timer (1000 / frameRate);

            //mTimer.addEventListener (TimerEvent.TIMER, OnTimerTick);
            
            //mLastFrameTime = getTimer ();
            
            //mTimer.start();
         //}
      //}     

      private var mGameStatusInfoTextField:TextField = new TextField ();
      private var mLastFpsTime:Number = 0;
      private var mFpsTickers:uint = 0;
      private var mFpsValue:Number = 0;
      private static var mLastFrameTime:Number = getTimer ();
      
      
      
      public function OnTimerTick (event:Event):void
      {
         if (mGame == null)
            return;
         
         var now:Number = getTimer ();
         var escapedTime:Number = now - mLastFrameTime;
         mLastFrameTime = now;
      
         // update game
         mGame.Update (escapedTime / 1000.0);
         
         
         // cal fps
         ++ mFpsTickers;
         if (now - mLastFpsTime > 1000)
         {
            mFpsValue = 1000 * mFpsTickers / (now - mLastFpsTime);
            mLastFpsTime = now;
            mFpsTickers = 0;
         }
         
         //
         if (Compiler::debugging)
         {
            mGameStatusInfoTextField.y = stage.stageHeight - mGameStatusInfoTextField.height;
            mGameStatusInfoTextField.autoSize = TextFieldAutoSize.LEFT;
            mGameStatusInfoTextField.selectable = false;
            mGameStatusInfoTextField.background = true;
            mGameStatusInfoTextField.backgroundColor = 0xFFFFDD;
            mGameStatusInfoTextField.text = "fps: " + mFpsValue + "\nmemory: " + System.totalMemory;
            this.addChild (mGameStatusInfoTextField);
         }
         
         // repaint render list
         //event.updateAfterEvent();
         //stage.invalidate ();
      }
   }
   
}