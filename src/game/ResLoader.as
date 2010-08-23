
package game {
   
   // try {} catch(e:Error) {} finally {}¡± in any place of your class crashes sothink
   
   import flash.utils.ByteArray;
   import mx.core.ByteArrayAsset;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   import flash.events.Event;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   import mx.core.SoundAsset;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.events.IOErrorEvent;

   
   import engine.asset.Sprite2dFile;
   import engine.asset.DefineFile;
   import engine.asset.LevelDefine;
   
   import engine.Engine;
   import engine.io.ResFileDescription;
   
   import game.Game;
   import game.res.kDefines;
   import game.res.kTemplate;
   
   import flash.system.SecurityDomain;
   import flash.system.Security;
   import flash.system.ApplicationDomain;



   public class ResLoader {
   
      public static var mInitialized:Boolean = false;

      [Embed(source="res/res.bin", mimeType="application/octet-stream")]
      private static var ResFile:Class;

/*
      [Embed(source="res/child.mp3")]
      private static var SoundChild:Class;

      [Embed(source="res/finished.mp3")]
      private static var SoundFinished:Class;

      [Embed(source="res/telport.mp3")]
      private static var SoundTelport:Class;

      [Embed(source="res/telport_start.mp3")]
      private static var SoundTelportStart:Class;

      [Embed(source="res/background_music.mp3")]
      private static var SoundBackground:Class;
*/

      
      private static var mResData:ByteArray;
      
      private static var mResFileDescs:Array;

      private static var mResFilesCount:int;
      
      public static function Initialize ():void
      {
         mResData = new ResFile ();
         
         var filesCount:int = mResData.readInt ();
         
         mResFilesCount = filesCount;
         mResFileDescs = new Array (filesCount);
         
         trace ("files count: " + filesCount);
         
         var fileID:int;
         
         for (fileID = 0; fileID < filesCount; ++ fileID)
         {
            mResFileDescs [fileID] = new ResFileDescription ();
            mResFileDescs [fileID].mDataSource = mResData;
            mResFileDescs [fileID].mFilePath = mResData.readUTF ();
            mResFileDescs [fileID].mFileType = mResData.readShort ();
            
            trace ("  - file path" + fileID + ": " + mResFileDescs [fileID].mFilePath + ", type id: " + mResFileDescs [fileID].mFileType);
         }
         
         var filesCount2:int = mResData.readInt ();
         trace ("files count 2: " + filesCount2); // should equal filesCount
         
         for (fileID = 0; fileID < filesCount2; ++ fileID)
         {
            mResFileDescs [fileID].mDataOffset = mResData.readInt ();
            mResFileDescs [fileID].mDataLength = mResData.readInt () - mResFileDescs [fileID].mDataOffset;
            
            trace ("  - file data position: [" + mResFileDescs [fileID].mDataOffset + ", " + (mResFileDescs [fileID].mDataOffset + mResFileDescs [fileID].mDataLength) + "), length: " + mResFileDescs [fileID].mDataLength );
         }
         
         
         LoadingNextImage (null);
      }
      
      private static function StartLoadingImage (imageFileID:int):void
      {
         trace ("start loading image file: " + imageFileID);
         
         var loader:Loader = new Loader ();
         
         //loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressListener);
         //loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadingNextImage );
         loader.contentLoaderInfo.addEventListener(Event.INIT, LoadingNextImage);
         
         mResFileDescs [imageFileID].mDataSource.position = mResFileDescs [imageFileID].mDataOffset;
         //loader.loadBytes (mResFileDescs [mLastLoadingImageFileID].mDataSource); // error
         
         var bytesData:ByteArray = new ByteArray ();
         bytesData.length = mResFileDescs [imageFileID].mDataLength;
         mResFileDescs [imageFileID].mDataSource.readBytes (bytesData, 0, mResFileDescs [imageFileID].mDataLength);         

         loader.loadBytes (bytesData);
      }
      
      
      private static var mLastLoadingImageFileID:int = -1;
      private static function LoadingNextImage (event:Event):void
      {
         if (event != null)
         {
            trace ("finished loading image file: " + mResFileDescs [mLastLoadingImageFileID].mFilePath);
            
            var loader:Loader = Loader(event.target.loader);
            
            trace ("   contentType=" + loader.contentLoaderInfo.contentType);
            
            var bitmap:Bitmap = Bitmap(loader.contentLoaderInfo.content);
            var bitmapData:BitmapData = bitmap.bitmapData;
            
            Engine.RegisterDataAsset ( mResFileDescs [mLastLoadingImageFileID].mFilePath, bitmapData);
         }
         
         while (true)
         {
            ++ mLastLoadingImageFileID;
            
            if (mLastLoadingImageFileID >= mResFilesCount)
               break;
               
            if (mResFileDescs [mLastLoadingImageFileID].mFileType == kDefines.FileType_ImageFile)
            {
               StartLoadingImage (mLastLoadingImageFileID);
               return;
            }
         }
         
         StartLoadingOtherAsset ();
      }
      
      private static function StartLoadingOtherAsset ():void
      {
         for (var fileID:int = 0; fileID < mResFilesCount; ++ fileID)
         {
            trace ("> --------------------- loading fileID:" + fileID + ") + path: " + mResFileDescs [fileID].mFilePath);
            
            var resFileDesc:ResFileDescription = mResFileDescs [fileID]
            var dataSrc:ByteArray = resFileDesc.mDataSource;
            dataSrc.position = resFileDesc.mDataOffset;            
            
            switch ( mResFileDescs [fileID].mFileType )
            {
               case kDefines.FileType_ImageFile:
               {
                  break;
               }
               case kDefines.FileType_Sprite2dFile:
               {
                  var sprite2dFile:Sprite2dFile = new Sprite2dFile (resFileDesc.mFilePath);
                  sprite2dFile.Load (dataSrc);
                  
                  Engine.RegisterDataAsset (resFileDesc.mFilePath, sprite2dFile);
                  break;
               }
               case kDefines.FileType_DefineFile:
               {
                  var defineFile:DefineFile = new DefineFile (resFileDesc.mFilePath);
                  defineFile.Load (dataSrc);
                  
                  Engine.RegisterDataAsset (resFileDesc.mFilePath, defineFile);
                  break;
               }
               case kDefines.FileType_LevelFile:
               {
                  //var levelDefine:LevelDefine = new LevelDefine ();
                  //levelDefine.LoadFromResFileDesc (mResFileDescs [fileID]);
                  //
                  //Engine.RegisterDataAsset (mResFileDescs [fileID].mFilePath, levelDefine);

                  var bytesData:ByteArray = new ByteArray ();
                  bytesData.length = resFileDesc.mDataLength;
                  dataSrc.readBytes (bytesData, 0, resFileDesc.mDataLength);
                  Engine.RegisterDataAsset (resFileDesc.mFilePath, bytesData);
                  Game.RegisterLevel (resFileDesc.mFilePath);
                  break;
               }
               case kDefines.FileType_SoundFile:
               {
                  break;
               }
               default:
            }
         }
         
         //LoadingNextSound (null);
         LoadSounds ();
         
         mResData = null;
         trace ("Res initialized");
         
         mInitialized = true;
      }
      
      private static function LoadSounds ():void
      {
         try
         {
         /*
            Engine.RegisterDataAsset ("child.mp3", new SoundChild() as SoundAsset);
            Engine.RegisterDataAsset ("finished.mp3", new SoundFinished() as SoundAsset);
            Engine.RegisterDataAsset ("telport.mp3", new SoundTelport() as SoundAsset);
            Engine.RegisterDataAsset ("telport_start.mp3", new SoundTelportStart() as SoundAsset);
            Engine.RegisterDataAsset ("background_music.mp3", new SoundBackground() as SoundAsset);
         */
         }
         catch (e:Error)
         {
            trace ("error: " + e);
         }
      }
      
      
      /*
      private static function StartLoadingSound (soundFileID:int):void
      {
         trace ("start loading sound file: " + mResFileDescs [soundFileID].mFilePath);
         
         try
         {
            var sound:Sound = new Sound( );
            
            sound.addEventListener(Event.COMPLETE, LoadingNextSound);
            sound.addEventListener(IOErrorEvent.IO_ERROR, LoadingNextSound);
            
            sound.load(new URLRequest(mResFileDescs [soundFileID].mFilePath));
            
            Engine.RegisterDataAsset (mResFileDescs [soundFileID].mFilePath, sound);
         }
         catch (e:Error)
         {
            trace ("error: " + e);
         }
      }
      
      
      private static var mLastLoadingSoundFileID:int = -1;
      private static function LoadingNextSound (event:Event):void
      {
         if (event != null)
         {
            if (event is IOErrorEvent)
               trace ("LoadingSoundError: " + mResFileDescs [mLastLoadingSoundFileID].mFilePath);
            else
               trace ("finished loading soud file: " + mResFileDescs [mLastLoadingSoundFileID].mFilePath);
         }
         
         while (true)
         {
            ++ mLastLoadingSoundFileID;
            
            if (mLastLoadingSoundFileID >= mResFilesCount)
               break;
            
            if (mResFileDescs [mLastLoadingSoundFileID].mFileType == kDefines.FileType_SoundFile)
            {
               StartLoadingSound (mLastLoadingSoundFileID);
               return;
            }
         }
      }
      */
   }
}