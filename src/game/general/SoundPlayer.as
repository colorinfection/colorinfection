
package game.general {

   import flash.media.Sound;
   import flash.media.SoundMixer;
   
   import engine.Engine;

   public class SoundPlayer
   {
   
      public function SoundPlayer ()
      {
      }
      
      private static var sSoundOn:Boolean = true;
      
      public static function IsSoundOn ():Boolean
      {
         return sSoundOn;
      }
      
      public static function SetSoundOnOff (on:Boolean):void
      {
         sSoundOn = on;
         
         if (! sSoundOn)
            StopAllSounds ();
      }
      
      public static function SwitchSoundOnOff ():void
      {
         SetSoundOnOff (! sSoundOn);
      }
   
      public static function PlaySoundByFilePath (filePath:String, loop:Boolean):void
      {
         if (! sSoundOn)
            return;
         
         
         var sound:Sound = Engine.GetDataAsset (filePath) as Sound;
         if (sound != null && sound.bytesTotal  > 0 && sound.bytesLoaded >= sound.bytesTotal )
            sound.play (0, 0x7fffffff);
      }
   
      public static function StopAllSounds ():void
      {
         SoundMixer.stopAll ();
      }
   }
}