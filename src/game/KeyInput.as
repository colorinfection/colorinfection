package game {

   import flash.events.Event;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   import flash.events.FocusEvent;
   
   import game.state.GameState_Level;
   
   import game.level.Level;
   
   public class KeyInput {
   
   
      public static var mLeftKeyPressed:Boolean;
      public static var mRightKeyPressed:Boolean;
      public static var mUpKeyPressed:Boolean;
      public static var mDownKeyPressed:Boolean;
      //public static var mRKeyPressed:Boolean;
      //public static var mUndoKeyPressed:Boolean;
      
      public static var mMouseLeftButtonHold:Boolean;
      public static var mMouseStageX:int;
      public static var mMouseStageY:int;
      
      /*
      public static var mMouseWheelPush:Boolean;
      public static var mMouseWheelDrag:Boolean;
      */
      
      public static var mChangeTargetKeyPressed:Boolean;
      public static var mComfirmKeyPressed:Boolean;
      
      public static function OnKeyDown (e:KeyboardEvent):void
      {
         trace ("e.keyCode = " + e.keyCode);
         
         switch (e.keyCode)
         {
         case Keyboard.LEFT:
         case 65:
            mLeftKeyPressed = true;
            break;
         case Keyboard.RIGHT:
         case 68:
            mRightKeyPressed = true;
            break;
         case Keyboard.UP:
         case 87:
            mUpKeyPressed = true;
            break;
            break;
         case Keyboard.DOWN:
         case 83:
            mDownKeyPressed = true;
            break;
         case Keyboard.SPACE:
            mComfirmKeyPressed = true;
            mChangeTargetKeyPressed = true;
            break;
         case 82: // R
            //mRKeyPressed = true;
            GameState_Level.sNeedRestart = true;
            break;
         case 66:// B
            Level.SetColorBlindMode (! Level.IsColorBlindMode ());
            break;
         case Keyboard.BACKSPACE:
         case Keyboard.ESCAPE:
            //mUndoKeyPressed = true;
            //GameState_Level.sNeedUndo = true;
            break;
         case Keyboard.ENTER:
            mComfirmKeyPressed = true;
            break;
         case 48: //Keyboard.NUMBER_0:
         case 96: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (0.0);
            break
         case 49: //Keyboard.NUMBER_1:
         case 97: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (1.0);
            break
         case 50: //Keyboard.NUMBER_2:
         case 98: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (2.0);
            break
         case 51: //Keyboard.NUMBER_3:
         case 99: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (3.0);
            break
         case 52: //Keyboard.NUMBER_4:
         case 100: //NUMPAD_4
            Level.SetPhysicsSimulationTimeScale (4.0);
            break
         case 53: //Keyboard.NUMBER_5:
         case 101: //NUMPAD_5
            Level.SetPhysicsSimulationTimeScale (5.0);
            break
         case 54: //Keyboard.NUMBER_3:
         case 102: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (6.0);
            break
         case 55: //Keyboard.NUMBER_3:
         case 103: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (7.0);
            break
         case 56: //Keyboard.NUMBER_3:
         case 104: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (8.0);
            break
         case 57: //Keyboard.NUMBER_3:
         case 105: //NUMPAD_0
            Level.SetPhysicsSimulationTimeScale (9.0);
            break
         case 192: // BACKQUOTE
         case 111: // NUMPAD_DIVIDE:
            Level.SetPhysicsSimulationTimeScale (0.5)
            break;
         default:
         }
      }
      
      public static function OnKeyUp (e:KeyboardEvent):void
      {
         switch (e.keyCode)
         {
         case Keyboard.LEFT:
         case 65:
            mLeftKeyPressed = false;
            break;
         case Keyboard.RIGHT:
         case 68:
            mRightKeyPressed = false;
            break;
         case Keyboard.UP:
         case 87:
            mUpKeyPressed = false;
            break;
         case Keyboard.DOWN:
         case 83:
            mDownKeyPressed = false;
            break;
         case Keyboard.SPACE:
            mComfirmKeyPressed = false;
            mChangeTargetKeyPressed = false;
            break;
         case 82: //Keyboard.R:
            //mRKeyPressed = false;
            break;
         case Keyboard.BACKSPACE:
         case Keyboard.ESCAPE:
            //mUndoKeyPressed = false;
            break;
         case Keyboard.ENTER:
            mComfirmKeyPressed = false;
            break;
         default:
         }
      }
      

      public static function OnMouseDown (e:MouseEvent):void
      {
         if ( ! sIsDeactived )
         {
            mMouseLeftButtonHold = true;

            mMouseStageX = e.stageX;
            mMouseStageY = e.stageY;
         }
         
         sIsDeactived = false;
      }
      
      public static function OnMouseUp (e:MouseEvent):void
      {
         ClearMouseInfo ();
         
         //mMouseStageX = e.stageX;
         //mMouseStageY = e.stageY;
      }
      
      public static function OnMouseMove (e:MouseEvent):void
      {
         mMouseStageX = e.stageX;
         mMouseStageY = e.stageY;
      }
      
      
      
      /*
      public static function OnMouseOut (e:MouseEvent):void
      {
      }
      
      public static function OnMouseClick (e:MouseEvent):void
      {
      }
      */
      
      /*
      public static function OnMouseWheel (e:MouseEvent):void
      {
         trace ("OnMouseWheel");
         
         if (e.delta < 0)
         {
            mMouseWheelDrag = true;
         }
         else if (e.delta > 0)
         {
            mMouseWheelPush = true;
         }
         
         //if (! e.shiftKey)
         //{
            //var e2:MouseEvent = e.clone () as MouseEvent;
            //e2.delta = - e.delta;
            //e2.shiftKey = true;
            //e.target.dispatchEvent(e2);  
         //}
         
         //var targetId:int = findTarget(e);
         //runtime.postEvent( new ScrollEvent( ScrollEvent.SCROLL_STEP, -e.delta, targetId ) );
         //e.preventDefault();
         //e.stopImmediatePropagation();
         //e.stopPropagation();
      }
      */
      
      /*
      public static function ClearMouseWheelInfo ():void
      {
         mMouseWheelPush = false;
         mMouseWheelDrag = false;
      }
      */
      
      public static function ClearKeys ():void
      {
         mLeftKeyPressed = false;
         mRightKeyPressed = false;
         mUpKeyPressed = false;
         mDownKeyPressed = false;
         //mRKeyPressed = false;
         //mUndoKeyPressed = false;
         
         mChangeTargetKeyPressed = false;
         mComfirmKeyPressed = false;
      }
      
      public static function ClearMouseInfo ():void
      {
         mMouseLeftButtonHold = false;
      }
      
      
      
      public static var sIsDeactived:Boolean = true;
      public static function OnDeactivate (e:Event):void
      {
         sIsDeactived = true;
         
         ClearKeys ();
         ClearMouseInfo ();
         

      }
      
      public static function OnActivate (e:Event):void
      {
      
      }
      
      
      /*
      public static var sIsFocusOut:Boolean = true;
      public static function OnFocusOut (e:Event):void
      {
         sIsFocusOut = true;
         
         ClearKeys ();
         ClearMouseInfo ();
         
      }
      
      public static function OnFocusIn (e:Event):void
      {
      
      }
      */
      
   }
   
}