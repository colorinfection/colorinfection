package game {
   
   import engine.util.Util;
   
   public class DomainStrategy {
      
      public static var sGameFileDomain:String = null;
      public static var sIsDomainValid:Boolean = true;
      
      public static var sShowExtraLevels:Boolean = true;
      
      public static var sShowSponsorOnStartupScreen:Boolean = false;
      public static var sShowSponsorOnMainmenuScreen:Boolean = false;
      
      
      public static var sShowSponsorOnLevelScreen:Boolean = false;
      public static var sShowTapirGamesOnLevelScreen:Boolean = true;
      
      
      public static var sShowClickAwayAd:Boolean = true;
      public static var sShowTapirGamesAd:Boolean = true;
      
      public static var sShowInterLevelAs:Boolean = true;
      
      
      //
      public static const kDomainsLocked:Boolean = false;
      
      public static const kValidDomains:Array = [
         "kongregate.com",
         "flashgamelicense.com",
      ];
      
      
      public static const kBigFishDomains:Array = [
         "bigfishgames.com", 
         "bigfishgames.com", 
         "bigfishgames.de", 
         "bigfishgames.fr", 
         "bigfishgames.es", 
         "bigfishgames.mx", 
         "bigfishgames.jp", 
      ];
      
      
      
      public static function Initialize (url:String):void
      {
         sGameFileDomain = Util.RetrieveDomainFromUrl (url);
         
         trace ("sGameFileDomain = " + sGameFileDomain);
         
         if (kDomainsLocked)
            sIsDomainValid = Util.CheckDomainValidity (sGameFileDomain, DomainStrategy.kValidDomains);
         
         if (sGameFileDomain == "tapirgames.com")
         {
            sShowExtraLevels = true;
            
            Config.kGameName = Config.kGameName_1;
            Config.kTitleText = Config.kTitleText_1;
            
            //trace ("tapirgames: " + Config.kGameName);
         }
         
         if (sGameFileDomain == "kongregate.com" || sGameFileDomain == "congregate.com")
         {
            sShowExtraLevels = true;
         }
         
         if (Util.IsLocalDomain (sGameFileDomain))
         {
            sShowExtraLevels = true;
         }
         
         
      }
   }
}