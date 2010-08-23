package game {
   
   import flash.display.DisplayObjectContainer;
   
   import com.kongregate.as3.client.KongregateAPI;
   import com.kongregate.as3.client.events.KongregateEvent;
   
   //import com.mindjolt.api.as3.MindJoltAPI;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.net.URLRequest;
   import flash.events.Event;
   
   
   import engine.util.Util;
   import engine.Engine;
   
   public class OnlineAPI {
      
      public static var sIsKongregate:Boolean = false;
      
      private static var sAPI_Initialized:Boolean = false;
      
      public static var sIsGuest:Boolean = true;
      
      private static var sMindJoltAPI:Object = null;
      public static var sIsMindJolt:Boolean = false;
      
      public function OnlineAPI ()
      {
      }
      
      public static function Initialize (container:DisplayObjectContainer):void
      {
         try
         {
            sIsKongregate = false;
            
            if (Engine.GetTopObjectUrl () == null)
               return;
            
            var domain:String = Util.RetrieveDomainFromUrl (Engine.GetTopObjectUrl ());
            
            trace ("domain = " + domain);
            
            if (domain == "kongregate.com" || domain == "congregate.com")
            {
               trace ("Is kongregate or congregate");
               
               sIsKongregate = true;
               
               var kongregate:KongregateAPI = new KongregateAPI();
               kongregate.addEventListener ( KongregateEvent.COMPLETE, Kongregate_OnInitComplete );
               
               container.addChild ( kongregate );
               
               trace ("kongregate api init");
            }
            else if (domain == "mindjolt.com")
            {
               trace ("is mindjolt");
               
               //
               var loader:Loader = new Loader();
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE, MindJolt_OnInitComplete);
               loader.load(new URLRequest("http://static.mindjolt.com/api/as3/scoreapi_as3_local.swf"));
               container.addChild(loader);
            }
            else
               trace ("OnlineAPI unknown domain");
         }
         catch (err:Error)
         {
            trace ("online initialize error");
         }
      }
      
      private static function MindJolt_OnInitComplete ( e:Event ):void 
      {
         sMindJoltAPI=e.currentTarget.content;
         sMindJoltAPI.service.connect();
         sAPI_Initialized = true;
         sIsMindJolt = true;
         trace ("[MindJoltAPI] service manually loaded");
      }
      
      private static function Kongregate_OnInitComplete ( e:KongregateEvent ):void
      {
         sAPI_Initialized = true;
          
         var kongregate:KongregateAPI = KongregateAPI.getInstance();
         kongregate.user.getPlayerInfo ( Kongregate_OnUserInfo );
      }
      
      public static function IsOk ():Boolean
      {
         return sAPI_Initialized;
      }
      
      
      private static function Kongregate_OnUserInfo ( playerData:Object ):void
      {
         trace ( "isGuest: "+ playerData.isGuest );
         
         sIsGuest = playerData.isGuest;
      }
      
      public static function MindJolt_UpdateOnlineData (highScore:int):void
      {
         if (sIsMindJolt)
         {
            trace ("[MindJoltAPI] submitScore starts");
            
            sMindJoltAPI.service.submitScore(highScore);
            
           trace ("[MindJoltAPI] submitScore done");
         }
      }
      
      public static function UpdateOnlineData (
                                       numFinishedLevels:int, highScore:int, 
                                       normalScore:int, hardScore:int, impossibleScore:int,
                                       AllNormalLevelsFinished:Boolean, AllHardLevelsFinished:Boolean, AllImpossibleLevelsFinished:Boolean, AllLevelsFinished:Boolean):void
      {
         trace ("----------------------------------------------- score: sIsGuest = " + sIsGuest + ", isOK = " + IsOk ());
            
         if ( ! IsOk () )
            return;
         
         try
         {
            // ====== sIsMindJolt ======
            if (sIsMindJolt)
            {
               MindJolt_UpdateOnlineData (highScore);
            }
            // ====== sIsKongregate ======
            else if (sIsKongregate)
            {
               var kongregate:KongregateAPI = KongregateAPI.getInstance();
               kongregate.user.getPlayerInfo ( Kongregate_OnUserInfo )
               
               if (sIsGuest)
                  return;
               
               trace ("user name: " + kongregate.user.getName ());
               
               // high score
               kongregate.scores.setMode ("AllLevels");
               kongregate.scores.submit (highScore);
               
               //kongregate.scores.setMode ("FinishedLevels");
               //kongregate.scores.submit (numFinishedLevels);
               
            //   kongregate.scores.setMode ("NormalLevels");
            //   kongregate.scores.submit (normalScore);
               
            //   kongregate.scores.setMode ("HardLevels");
            //   kongregate.scores.submit (hardScore);
               
            //   kongregate.scores.setMode ("ImpossibleLevels");
            //   kongregate.scores.submit (impossibleScore);
               
               // statistics
            //   kongregate.stats.submit ( "AllNormalLevelsFinished", AllNormalLevelsFinished ? 1 : 0 ); 
            //   kongregate.stats.submit ( "AllHardLevelsFinished", AllHardLevelsFinished ? 1 : 0 ); 
            //   kongregate.stats.submit ( "AllImpossibleLevelsFinished", AllImpossibleLevelsFinished ? 1 : 0 ); 
               kongregate.stats.submit ( "AllLevelsFinished", AllLevelsFinished ? 1 : 0 ); 
            }
            else
            {
               trace ("UpdateOnlineData nothing");
               return;
            }
            
            trace ("UpdateOnlineData ok");
         }
         catch (err:Error)
         {
            trace ("UpdateOnlineData error");
         }
      }
   }
   
}
