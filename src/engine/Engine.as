package engine {

   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   
   import flash.utils.Dictionary;
   
   public class Engine {
   
   

   
      public static function Initialize ():void
      {
      }
      
      
      private static var mTopObjectUrl:String = "";
      public static function GetTopObjectUrl ():String
      {
         return mTopObjectUrl;
      }
            
      public static function SetTopObjectUrl (url:String):void
      {
         mTopObjectUrl = url;
      }
            
//======================================================================================================
// asset list
//======================================================================================================
      
      private static var mAssetDict:Dictionary = new Dictionary ();
      
      public static function RegisterDataAsset (assetName:String, asset:Object):void
      {
         mAssetDict [assetName] = asset;
      }
      
      public static function UnregisterDataAsset (assetName:String):void
      {
         delete mAssetDict [assetName];
      }
      
      public static function GetDataAsset (assetName:String):Object
      {
         return mAssetDict [assetName];
      }
   }
   
}