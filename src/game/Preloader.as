package game {
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.events.IOErrorEvent;
    import flash.utils.getDefinitionByName;
    //import flash.events.Event;
    
   import game.display.DialogBox;
   import game.Config;
   import game.DomainStrategy;
   
   import mochi.MochiAd;
   import mochi.MochiBot;
   import mochi.MochiServices;
   import mochi.MochiScores;
   
    // Must be dynamic!
    public dynamic class Preloader extends MovieClip {
        public static var _mochiads_game_id:String = "12c94695315e0402"; // Color Infection 2
        public static var _mochiads_board_id:String = "c6055f5e1df4baa7"; // Color Infection 2
        
        // Keep track to see if an ad loaded or not
        private var did_load:Boolean;

        // Change this class name to your main class
        public static var MAIN_CLASS:String = "game.GameCanvas";
        
        // url
        public static var sSwfUrl:String = null;

        // Substitute these for what's in the MochiAd code
        public static var GAME_OPTIONS:Object = {id: _mochiads_game_id, res:"600x630"};
        
        public static var sPreloader:MovieClip;

        public function Preloader() 
        {
            super();
            
            sPreloader = this;
            
            var f:Function = function(ev:IOErrorEvent):void {
                // Ignore event to prevent unhandled error exception
            }
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, f);
            
            sSwfUrl = loaderInfo.url;
            trace ("sSwfUrl= " + sSwfUrl);
            trace ("root.loaderInfo.url= " + root.loaderInfo.url);
            trace ("root.loaderInfo.loaderURL= " + root.loaderInfo.loaderURL);
            
            
            DomainStrategy.Initialize (sSwfUrl);
            
            
            // mochi bot
            if (sSwfUrl == null || sSwfUrl.indexOf ("//:localhost") < 0)
               MochiBot.track(this, "b83a3b4b"); //  Color Infection 2
            
            // mochi services
            MochiServices.connect(_mochiads_game_id, this);
            MochiScores.setBoardID(_mochiads_board_id);
            
            // loader ...
            var opts:Object = {};
            for (var k:String in GAME_OPTIONS) {
                opts[k] = GAME_OPTIONS[k];
            }

            opts.ad_started = function ():void {
                did_load = true;
            }

            opts.ad_finished = function ():void {
                
                //HideTitle ();
                
                
                // don't directly reference the class, otherwise it will be
                // loaded before the preloader can begin
                var mainClass:Class = Class(getDefinitionByName(MAIN_CLASS));
                var app:Object = new mainClass();
                addChild(app as DisplayObject);
                if (app.init) {
                    app.init(did_load);
                }
            }
      
            //var adContainer:MovieClip = MochiAd.createEmptyMovieClip(this, "_ad_clip", 3);
            //adContainer.y = 100;
      
            //opts.clip = adContainer; //this;
            opts.clip = this;
            MochiAd.showPreGameAd(opts);
            
            //ShowTitle ();
            
            //addEventListener(Event.ENTER_FRAME, Update);
        }
        
        /*
        private var mTitleText:DialogBox;
        
        private function ShowTitle ():void
        {
            var titleContainer:MovieClip = MochiAd.createEmptyMovieClip(this, "_game_title", 3);
            
            if (mTitleText == null)
            {
               mTitleText = new DialogBox ();
               titleContainer.addChild (mTitleText);
               
               mTitleText.SetText (Config.kTitleText, true);
               mTitleText.SetCached (true);
               mTitleText.SetBackgroundVisible (false);
               
               mTitleText.Rebuild ();
            }
            
            mTitleText.x = (App::Default_Width - mTitleText.width) / 2;
            mTitleText.y = 20;
        }
        
        private function HideTitle ():void
        {
            if (mTitleText != null && mTitleText.parent != null)
            {
               mTitleText.parent.removeChild (mTitleText);
            }
        }
        
       private function Update (e:Event):void
       {  
           ShowTitle ();
       }
       */
    }

}
