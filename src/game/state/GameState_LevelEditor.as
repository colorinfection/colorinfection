package game.state {

   import flash.display.Sprite;
   import flash.display.DisplayObject;
   
   import flash.display.Shape;
   
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import flash.events.MouseEvent;
   
   import game.level.Level;
   
   import game.GameState;
   import game.level.Level;
   
   import game.Game;
   
   import game.Config;
   
   
   public class GameState_LevelEditor extends GameState 
   {
   
      private var mEntityContainer:Sprite;
      private static var mBackground:Shape;
      private static var mBackground2:Shape;
      
      private var mLevel:Level;
      
      private var mTopBlackBar:Shape;
      private var mBottomBlackBar:Shape;
      private var mBlackBarMinHeight:uint = 23;
      
      private var mExitMenu:TextField;
      
      
      public function GameState_LevelEditor (game:Game)
      {
         super (game);
      }
      
      
      override public function Initialize ():void
      {
         //
         if (mBackground == null)
         {
            mBackground = new Shape();
            mBackground.graphics.beginFill(Config.StaticObjectColor);
            mBackground.graphics.lineStyle(0, 0xDDDDA0);
            mBackground.graphics.drawRect(0, 0, App::Default_Width + 100, App::Default_Height + 100);
            mBackground.graphics.endFill();
         }         
         mBackground.x = -50;
         mBackground.y = -50;
         mGame.addChild (mBackground);
         
         if (mBackground2 == null)
         {
            mBackground2 = new Shape();
            mBackground2.graphics.beginFill(0xAAAA80);
            mBackground2.graphics.lineStyle(0, 0xDDDDA0);
            mBackground2.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height);
            mBackground2.graphics.endFill();
         }
         mBackground2.x = 0;
         mBackground2.y = 0;
         mGame.addChild (mBackground2);
         
         
         
         //
         mEntityContainer = new Sprite ();
         mGame.addChild (mEntityContainer);
         
         
         //
         mTopBlackBar = new Shape();
         mTopBlackBar.graphics.beginFill(0x0);
         mTopBlackBar.graphics.lineStyle(0, 0x0);
         mTopBlackBar.graphics.drawRect(0, 0, App::Default_Width, App::Default_Height / 2);
         mTopBlackBar.graphics.endFill();
         
         mEntityContainer.addChild(mTopBlackBar);
         
         mBottomBlackBar = new Shape();
         mBottomBlackBar.graphics.beginFill(0x0);
         mBottomBlackBar.graphics.lineStyle(0, 0x0);
         mBottomBlackBar.graphics.drawRect(0, - App::Default_Height / 2, App::Default_Width, App::Default_Height / 2);
         mBottomBlackBar.graphics.endFill();
         mBottomBlackBar.y = App::Default_Height;
         
         mEntityContainer.addChild(mBottomBlackBar);
         
         //
         mExitMenu = CreateMenuText (" Menu ", true);
         mExitMenu.x = 3;
         mExitMenu.y = 1;
         
         
         ChangeState ( State_OpenScreen );
      }
      
      override public function Destroy ():void
      {
         mGame.removeChild (mEntityContainer);
         mGame.removeChild (mBackground);
         mGame.removeChild (mBackground2);
      }
      
      
      private function CreateMenuText (label:String, needEventHandlers:Boolean):TextField
      {
         var menu:TextField = new TextField ();
         
         menu.autoSize = TextFieldAutoSize.LEFT;
         menu.selectable = false;
         menu.background = false;
         //menu.backgroundColor = 0xA0A0FF;
         menu.textColor = 0xFFFF00;
         menu.text = label;
         
         if (needEventHandlers)
         {
            menu.addEventListener( MouseEvent.CLICK, OnMenuClick );
            menu.addEventListener( MouseEvent.MOUSE_OVER, OnMenuMouseOver );
            menu.addEventListener( MouseEvent.MOUSE_OUT, OnMenuMouseOut );
         }
         
         //if (menu.height > mBlackBarMinHeight - 2)
         //   mBlackBarMinHeight = menu.height + 2;
         
         return menu;
      }
      
      private function OnMenuClick( event:MouseEvent ):void 
      {
         var menu:TextField = (event.target as TextField);
         if (menu == mExitMenu)
         {
            GoToMainMenu ();
         }
      }
      
      private function OnMenuMouseOver (event:MouseEvent):void
      {
         var menu:TextField = (event.target as TextField);
         menu.background = true;
         menu.backgroundColor = 0xDDDDFF;
         menu.textColor = 0x0;
      }
      
      private function OnMenuMouseOut (event:MouseEvent):void
      {
         var menu:TextField = (event.target as TextField);
         menu.background = false;
         menu.textColor = 0xFFFF00;
      }
      
      private function GoToMainMenu ():void
      {
      
         //
         mEntityContainer.removeChild (mExitMenu);
         
         ChangeState ( State_CloseScreen );
      }
      
      private function ChangeState (newState:int):void
      {
         mStateTicker = 0;
         mState = newState;
      }
      
      private function AddOtherEntities ():void
      {
         mEntityContainer.addChild (mExitMenu);
      }
      
      private var mState:int = State_OpenScreen;
      private var mStateTicker:int;
      
      private static const State_OpenScreen:int = 0;
      private static const State_Editing:int = 1;
      private static const State_CloseScreen:int = 2;
      
      override public function Update (escapedTime:Number):void
      {
          mStateTicker ++;
          
          var dScaleY:Number = 0.03;
          
          trace ("mState = " + mState);
          
         switch (mState)
         {
            case State_OpenScreen: // open screen
            {
               mTopBlackBar.scaleY -= dScaleY;
               mBottomBlackBar.scaleY -= dScaleY;
               
               if (mTopBlackBar.height <= mBlackBarMinHeight && mBottomBlackBar.height <= mBlackBarMinHeight)
               {
                  mTopBlackBar.height = mBottomBlackBar.height = mBlackBarMinHeight;
                  
                  AddOtherEntities ();
                  
                 ChangeState ( State_Editing );
               }
                  
               break;
            }
            case State_CloseScreen: // close screen
            {
               mTopBlackBar.scaleY += dScaleY;
               mBottomBlackBar.scaleY += dScaleY;
               
               if (mTopBlackBar.scaleY >= 1 && mBottomBlackBar.scaleY >= 1)
               {
                  
                  mGame.SetNextGameStateID (Game.k_GameState_MainMenu);
               }
               
               break;
            }
            case State_Editing:
            {
               break;
            }
         }
      }
      
   }
}