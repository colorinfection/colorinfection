
var packageNames = JavaImporter();

packageNames.importPackage(Packages.com.meme.editor.model.sprite2d);
packageNames.importPackage(Packages.com.meme.editor.level);
packageNames.importPackage(Packages.com.meme.editor.level.define);
packageNames.importPackage(Packages.com.meme.editor.property);
packageNames.importPackage(Packages.com.meme.io.editor);
packageNames.importPackage(Packages.com.meme.io.helper);
packageNames.importPackage(Packages.com.meme.io.packager);
packageNames.importPackage(Packages.com.meme.util);
packageNames.importPackage(Packages.java.lang);
packageNames.importPackage(Packages.java.io);
packageNames.importPackage(Packages.java.util);
packageNames.importPackage(Packages.java.awt.image);


var kFileType_Image    = new String ("ImageFile");
var kFileType_Sprite2d = new String ("Sprite2dFile");
var kFileType_Define   = new String ("DefineFile");
var kFileType_Level    = new String ("LevelFile");
var kFileType_Sound    = new String ("SoundFile");


var _ResBaseDir;
var _ResCompiledDir;  
var _GameMode = new String ("Adventure");

   
   
   
   
   
   



 

var _LevelFilesToBePacked_decathlon = [
/*
  "level_00.xLevel",  // game goal
  "level_01.xLevel",  // 
  "level_02.xLevel",  // 
  "level_03.xLevel",  // 
  "level_04.xLevel",  // 
  "level_05.xLevel",  // 
  "level_06.xLevel",  // 
  "level_07.xLevel",  // 
  "level_08.xLevel",  // 
  "level_09.xLevel",  // 
  "level_26.xLevel",  // 
  "level_26.xLevel",  // 
  "level_26.xLevel",  // 
  "level_26.xLevel",  // 

  
  "level_puzzle_00.xLevel",  // 
  "level_puzzle_01.xLevel",  // 
  "level_puzzle_02.xLevel",  // 
  "level_puzzle_03.xLevel",  // 
  "level_puzzle_04.xLevel",  // 
*/
  
  "level_18-easy.xLevel",  // 2
  "level_17-slow.xLevel",  // 2
   
  "level_20.xLevel",  // 3, sailing
  
  "level_25_cw.xLevel",  // 3
  "level_25_ccw.xLevel",  // 3
  "level_29.xLevel",  // 3  
  "level_30.xLevel",  // 3
  "level_23-1_branch.xLevel",  // 3
  "level_19_cw.xLevel",  // 3
  "level_19_ccw.xLevel",  // 3
  "level_28.xLevel",  // 3
  "level_18.xLevel",  // 3
  "level_17.xLevel",  // 3
  
  "level_21.xLevel",  // 4, beam balance
  
  "level_26.xLevel",  // 4
  
  "level_22.xLevel",  // hard
  
  "level_18-speed_1.xLevel",  // hard
  "level_18-narrow_1.xLevel",  // hard
  
  "level_17-speed_1.xLevel",  // hard
  "level_17-narrow_1.xLevel",  // hard
  
  "level_19_cw-3_slots.xLevel",  // 4
  "level_19_ccw-3_slots.xLevel",  // 4
  
  "level_23-2_branches.xLevel",  // 4
  "level_23-4_branches.xLevel",  // 4
  
  "level_17-narrow_2.xLevel",  // impossible 
  
  "level_23-1_branch-speed.xLevel",  // impossible
  
  "level_25_cw-narrow_1.xLevel",  // 5
  "level_25_ccw-narrow_1.xLevel",  // 5
  
  "level_26-hard.xLevel",  // impossible
  
//  "level_27.xLevel",  // 
//  "level_27-hard.xLevel",  // 
   
  "level_28-hard.xLevel",  // 5

];

var _LevelFilesToBePacked_puzzle = [

  "level_puzzle_B08_new.xLevel",  //  1,  小球掉入缝隙
  "level_puzzle_B09_new.xLevel",  //  2, 小球掉入2个缝隙
  "level_puzzle_B04.xLevel",  //  2, 挡板保护绿球
  "level_puzzle_B32.xLevel",  //  2, 一代的改编版
  "level_puzzle_B52_2.xLevel",  //   2,  绿球垫起斜坡
  
  "level_puzzle_B33.xLevel",  //  2, 简单释放次序
  "level_puzzle_B52.xLevel",  //  2, 一代的改编版
  "level_puzzle_B00_new.xLevel",  //  2, 释放次序, 阻挡转动
  "level_puzzle_B06_new.xLevel",  //  2, 释放次序, E字型器械
  "level_puzzle_B01_new.xLevel",  //  2, 链球
  
  "level_puzzle_B02_new.xLevel",  //  3, 5个5个释放打开闸门
  "level_puzzle_B03_new.xLevel",  //  4, 释放次序,  小球通过,  大球被阻
  "level_puzzle_B20_new.xLevel",  //  2,  多米诺  
  "level_puzzle_B12_new.xLevel",  //  1, 推来推去
  "level_puzzle_B18_new.xLevel",  //  2, 趁机插入绿色小球
  
  "level_puzzle_B07_new.xLevel",  //  2,  杠杆, 挑起小球
  "level_puzzle_B05_new.xLevel",  //  4, 完全碰撞
  "level_puzzle_B16_new.xLevel",  //  3, 吊针, timing  
  "level_puzzle_B15_new.xLevel",  //  3, 小车, timing, 多米诺
  "level_puzzle_B11_new.xLevel",  //  3, 疯狂撒小球
  
  "level_puzzle_B17_new.xLevel",  //  2, 掀盖  
  //"level_puzzle_B21_new.xLevel",  //  2, 一代的改编版, 推箱子
  "level_puzzle_B10_new.xLevel",  //  5, 难, 
  "level_puzzle_B10_new_2.xLevel",  //   5, 难, 
  "level_puzzle_B10_new_3.xLevel",  //   5, 难, 
  "level_puzzle_B10_new_5.xLevel",  //   5, 难, 
];

var _LevelFilesToBePacked_domino = [
  "level_04.xLevel",  // 
  "level_06.xLevel",  // 
  "level_07.xLevel",  // 
  "level_puzzle_05.xLevel",  // 
  "level_puzzle_28.xLevel",  // 
  "level_puzzle_00.xLevel",  // 
  "level_puzzle_01.xLevel",  // 



  
  
  
  
  
  
  
  "level_08.xLevel",  // 
  "level_09.xLevel",  // 
  "level_domino_01.xLevel",  // 
  "level_domino_02.xLevel",  // 
"  level_domino_06.xLevel", 

];

var _SoundFilesToBePacked = [
];

var _ImageFilesToBePacked = [
//   "logo.png",
//     "tapirgames_1.jpg",
     
];

var _SpriteFilesToBePacked = [
//   "misc.xSprite2d",
];


with (packageNames)
{

  function FileInfo (resFullPath, gamePath, fileType)
   {
      this.resPath  = resFullPath;
      this.gamePath  = gamePath.replace ('\\', '/');
      this.fileType  = fileType;
   }
	
//=================================================================
//
//=================================================================

   
   var _ActorTypeCollector        = new ObjectCollector ();
   var _AppearanceTypeCollector   = new ObjectCollector ();
   var _PropertyTypeCollector     = new ObjectCollector ();
   var _FileTypeCollector         = new ObjectCollector ();
   
   var _ImageFileCollector        = new ObjectCollector ();
   var _Sprite2dFileCollector     = new ObjectCollector ();
   var _DefineFileCollector       = new ObjectCollector ();
   var _LevelFileCollector        = new ObjectCollector ();
   
   var _PackedFileInfoList = new Vector ();

   

   
   function collectActorTypes ()
   {
      _ActorTypeCollector.addObject (ActorFactory.ActorType_General);
   }
   
   function collectAppearanceTypes ()
   {
      _AppearanceTypeCollector.addObject (AppearanceFactory.AppearanceType_Sprite2d);
      _AppearanceTypeCollector.addObject (AppearanceFactory.AppearanceType_Background2d);
      _AppearanceTypeCollector.addObject (AppearanceFactory.AppearanceType_Box2d);
      _AppearanceTypeCollector.addObject (AppearanceFactory.AppearanceType_Circle);
      _AppearanceTypeCollector.addObject (AppearanceFactory.AppearanceType_Line2d);
   }

   function collectPropertyTypes ()
   {
      _PropertyTypeCollector.addObject (PropertyFactory.ValueType_Number);
      _PropertyTypeCollector.addObject (PropertyFactory.ValueType_String);
      _PropertyTypeCollector.addObject (PropertyFactory.ValueType_Items);
      _PropertyTypeCollector.addObject (PropertyFactory.ValueType_EntityRef);
      _PropertyTypeCollector.addObject (PropertyFactory.ValueType_Boolean);
   }

   function collectFileTypes ()
   {
      _FileTypeCollector.addObject (kFileType_Image);
      _FileTypeCollector.addObject (kFileType_Sprite2d);
      _FileTypeCollector.addObject (kFileType_Define);
      _FileTypeCollector.addObject (kFileType_Level);
      _FileTypeCollector.addObject (kFileType_Sound);
   }
   
   function collectPackedFiles ()
   {
      println ("Collect Res Files:");
      
      var fileCollector = FileCache.getFileCollector ();
      
      println ("fileCollector.getObjectsCount () = " + fileCollector.getObjectsCount ());
   
      
     // first, seperated files
     
  	  for (var fileID=0; fileID < _SoundFilesToBePacked.length; fileID ++)
     {
			var binFilename = FileUtil.getFullPathFilename (_SoundFilesToBePacked [fileID], _ResBaseDir);
			var gamePath = _SoundFilesToBePacked [fileID];
         
         var fileinfo = new FileInfo (binFilename, gamePath, kFileType_Sound);
         _PackedFileInfoList.add (fileinfo);
     }
     
  	  for (var fileID=0; fileID < _ImageFilesToBePacked.length; fileID ++)
     {
			var binFilename = FileUtil.getFullPathFilename (_ImageFilesToBePacked [fileID], _ResBaseDir);
			var gamePath = _ImageFilesToBePacked [fileID];
         
         var fileinfo = new FileInfo (binFilename, gamePath, kFileType_Image);
         _PackedFileInfoList.add (fileinfo);
     }
     
     for (var fileID=0; fileID < _SpriteFilesToBePacked.length; fileID ++)
     {
         var fullPathFilename = FileUtil.getFullPathFilename (_SpriteFilesToBePacked [fileID], _ResBaseDir);
         
         FileCache.getSprite2dFile (fullPathFilename);
	      var file = FileUtil.getFile (fullPathFilename);
         var fileAsset = FileCache.getLoadedFileAsset (file);

   		 if (fileAsset instanceof Sprite2dFile) // must be true
   		 {
   		    _Sprite2dFileCollector.addObject (file);
   			
   			var binFilename = file.getCanonicalPath () + ".bin";
   			var gamePath = FileUtil.getRelativePathFilename (file.getCanonicalPath (), _ResBaseDir);

   			writeSprite2dFile (fileAsset, binFilename);

   			var fileinfo = new FileInfo (binFilename, gamePath, kFileType_Sprite2d);			
   			_PackedFileInfoList.add (fileinfo);
   		 }
     }

     // collect other refed by level files
	  
     
	   for (var fileID=0; fileID < fileCollector.getObjectsCount (); fileID ++)
      {
	     var file = fileCollector.getObjectAt(fileID);
	     var fileAsset = FileCache.getLoadedFileAsset (file);
		  if (fileAsset instanceof DefineFile)
		  {
          var defineFile = fileAsset;
			 var binFilename = file.getCanonicalPath () + ".bin";
			 writeDefineBinFile (defineFile, binFilename);
          
          var codeFilePath = FileUtil.getFilenameWithoutExt (file.getCanonicalPath ());
		    codeFilePath = codeFilePath.toUpperCase().substring (0,1) + (codeFilePath.length() > 1 ? codeFilePath.substring (1) : "");
		    codeFilePath = FileUtil.getFullPathFilename ("k" + codeFilePath + ".as", _ResCompiledDir);
          writeDefineCodeFile (defineFile, codeFilePath);
		  }
	  }
     
     
	  for (var fileID=0; fileID < fileCollector.getObjectsCount (); fileID ++)
      {
	     var file = fileCollector.getObjectAt(fileID);
	     var fileAsset = FileCache.getLoadedFileAsset (file);
		 if (fileAsset instanceof BufferedImage)
		 {
		    _ImageFileCollector.addObject (file);
			
			var fullPath = file.getCanonicalPath ();
			var gamePath = FileUtil.getRelativePathFilename (fullPath, _ResBaseDir);
         
         println ("  - " + fullPath);
			
			var fileinfo = new FileInfo (fullPath, gamePath, kFileType_Image);			
			_PackedFileInfoList.add (fileinfo);
		 }
	  }
	  for (var fileID=0; fileID < fileCollector.getObjectsCount (); fileID ++)
      {
	     var file = fileCollector.getObjectAt(fileID);
	     var fileAsset = FileCache.getLoadedFileAsset (file);
		 if (fileAsset instanceof Sprite2dFile)
		 {
		    _Sprite2dFileCollector.addObject (file);
			
			var binFilename = file.getCanonicalPath () + ".bin";
			var gamePath = FileUtil.getRelativePathFilename (file.getCanonicalPath (), _ResBaseDir);
			
			writeSprite2dFile (fileAsset, binFilename);

			var fileinfo = new FileInfo (binFilename, gamePath, kFileType_Sprite2d);			
			_PackedFileInfoList.add (fileinfo);
		 }
	  }
	  for (var fileID=0; fileID < fileCollector.getObjectsCount (); fileID ++)
      {
	     var file = fileCollector.getObjectAt(fileID);
	     var fileAsset = FileCache.getLoadedFileAsset (file);
		 if (fileAsset instanceof DefineFile)
		 {
		    _DefineFileCollector.addObject (file);
			
			var binFilename = file.getCanonicalPath () + ".bin";
			var gamePath = FileUtil.getRelativePathFilename (file.getCanonicalPath (), _ResBaseDir);
			
			//writeDefineBinFile (fileAsset, binFilename);

			var fileinfo = new FileInfo (binFilename, gamePath, kFileType_Define);			
			_PackedFileInfoList.add (fileinfo);
		 }
	  }
	  for (var fileID=0; fileID < fileCollector.getObjectsCount (); fileID ++)
      {
	     var file = fileCollector.getObjectAt(fileID);
	     var fileAsset = FileCache.getLoadedFileAsset (file);
		 if (fileAsset instanceof LevelFile)
		 {
		    _LevelFileCollector.addObject (file);
			
			var binFilename = file.getCanonicalPath () + ".bin";
			var gamePath = FileUtil.getRelativePathFilename (file.getCanonicalPath (), _ResBaseDir);
			
			writeLevelBinFile (fileAsset, binFilename);

			var fileinfo = new FileInfo (binFilename, gamePath, kFileType_Level);			
			_PackedFileInfoList.add (fileinfo);
		 }
	  }
     

   }

   
   function writeSprite2dFile (sprite2dFile, filename)
   {
      println ("  - " + filename);
      
      Sprite2dBinFileWriter.writeSprite2dBinFile (sprite2dFile, filename);
   }

   function writeLevelBinFile (levelFile, filename)
   {
      println ("  - " + filename);
      
      var binFilePackager = new BinaryFilePackager (filename);
      
      {
         var defineFilename = levelFile.getDefineFile ().getHostFilename ();
         var relativePath = FileUtil.getRelativePathFilename (defineFilename, levelFile.getHostFilename ());

         var playfieldWidth  = levelFile.getPlayfieldWidth ();
         var playfieldHeight = levelFile.getPlayfieldHeight ();

         var actorSet = levelFile.getActorSet ();

         binFilePackager.writeUTF (relativePath);
         binFilePackager.writeShort (playfieldWidth);
         binFilePackager.writeShort (playfieldHeight);

         binFilePackager.writeShort (actorSet.getChildrenCount());

         for (var actorID = 0; actorID < actorSet.getChildrenCount (); ++ actorID)
         {
            var actor = actorSet.getChildByIndex (actorID);
            writeActor (actor, binFilePackager);
         }

		binFilePackager.writeByte (0);
      }
     
      binFilePackager.close ();
   }
   
   function writeActor (actor, binFilePackager)
   {
		var actorTemplate = actor.getActorTemplate ();
      
      binFilePackager.writeByte (1); //  means: actor data followed
      
      if (actorTemplate.isReserved ())
      {
         binFilePackager.writeByte (1);
      }
      else
      {
         binFilePackager.writeByte (0);         
         binFilePackager.writeShort (actorTemplate.getIndex ());
         
         binFilePackager.writeShort (actor.getPosX ());
         binFilePackager.writeShort (actor.getPosY ());
         binFilePackager.writeShort (actor.getZOrder ());
         binFilePackager.writeFloat (actor.getAngle ());
         binFilePackager.writeFloat (actor.getScaleX ());
         binFilePackager.writeFloat (actor.getScaleY ());
         //binFilePackager.writeBoolean (actor.isFlipX ());
         //binFilePackager.writeBoolean (actor.isFlipY ());
         
         var constomPropertyList = actor.getCostomPropertyList ();
		   writePropertyList (constomPropertyList, binFilePackager);
         
         var appearanceDefines = actorTemplate.getAppearanceDefines ();
         
         // assert appearanceDefines.size () == actor.getAppearancesCount ()         
         binFilePackager.writeByte (actor.getAppearancesCount ());
         
		   for (var appearanceID = 0; appearanceID < actor.getAppearancesCount (); ++ appearanceID)
		   {
		      var appearance = actor.getAppearance (appearanceID);
            var appearanceDefine = appearanceDefines.get (appearanceID);
		      writeAppearance (appearance, appearanceDefine, binFilePackager);
		   }
      }
   }
   
   function writeAppearance (appearance, appearanceDefine, binFilePackager)
   {
		var appearanceName = appearanceDefine.getName (); // == appearance.getName ();
		var appearanceType = appearanceDefine.getType ();
      
		if (appearanceType.equals (AppearanceFactory.AppearanceType_Sprite2d))
		{
         // appearance instanceof Sprite2dAppearance
         var animatedModule = appearance.getAniamation ();
         if (animatedModule == null)
            binFilePackager.writeShort (-1);
         else
            binFilePackager.writeShort (animatedModule.getIndex ());
		}
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Background2d))
		{
         // appearance instanceof Background2dAppearance
		   var tiled2dBackground = appearance.getBackground ();
         if (tiled2dBackground == null)
            binFilePackager.writeShort (-1);
         else
            binFilePackager.writeShort (tiled2dBackground.getIndex ());
		}
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Box2d))
		{
         // appearance instanceof Box2dAppearance
		   binFilePackager.writeShort (appearance.getLeft ());
		   binFilePackager.writeShort (appearance.getTop ());
		   binFilePackager.writeShort (appearance.getRight ());
		   binFilePackager.writeShort (appearance.getBottom ());
		   
		}   
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Circle))
		{
         // appearance instanceof CircleAppearance
		   binFilePackager.writeShort (appearance.getRadius ());
		   binFilePackager.writeShort (appearance.getCenterX ());
		   binFilePackager.writeShort (appearance.getCenterY ());
		}   
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Line2d))
		{
         // appearance instanceofLine2dAppearance
		   binFilePackager.writeShort (appearance.getPoint1X ());
		   binFilePackager.writeShort (appearance.getPoint1Y ());
		   binFilePackager.writeShort (appearance.getPoint2X ());
		   binFilePackager.writeShort (appearance.getPoint2Y ());
		}   
   }
   
   
   function writeDefineBinFile (defineFile, filename)
   {
      println ("  - " + filename);
      
      var binFilePackager = new BinaryFilePackager (filename);
	  
      var actorTemplateSet = defineFile.getActorTemplateSet ();
	  
	  binFilePackager.writeShort (actorTemplateSet.getChildrenCount());
	  
	  for (var templateID = 0; templateID < actorTemplateSet.getChildrenCount (); ++ templateID)
	  {
	     var actorTemplate = actorTemplateSet.getChildByIndex (templateID);
		 var propertySet = actorTemplate.getPublicProperties(); 
		 
		 var templateName = actorTemplate.getName ();
		 var instanceActorType = actorTemplate.getActorType ();
		 var instanceActorTypeID = _ActorTypeCollector.getObjectIndex (instanceActorType);
		 var instanceActorDefaultZOrder = actorTemplate.getDefaultZOrder ();
		 
		 binFilePackager.writeUTF (templateName);
		 binFilePackager.writeShort (instanceActorTypeID);
		 binFilePackager.writeShort (instanceActorDefaultZOrder);
		 
		 var templatePropertyDefines = actorTemplate.getTemplatePropertyDefines ();
		 writePropertyDefineBlockList (templatePropertyDefines, binFilePackager);
		 
		 var costomPropertyList = actorTemplate.getCostomPropertyList ();
		 writePropertyList (costomPropertyList, binFilePackager);
		 
		 var instancePropertyDefines = actorTemplate.getInstancePropertyDefines ();
		 writePropertyDefineBlockList (instancePropertyDefines, binFilePackager);
		 
		 var appearanceDefines = actorTemplate.getAppearanceDefines ();
		 
		 binFilePackager.writeByte (appearanceDefines.size ());
		 
		 for (var appearanceDefineID = 0; appearanceDefineID < appearanceDefines.size (); ++ appearanceDefineID)
		 {
		    var appearanceDefine = appearanceDefines.get (appearanceDefineID);
			
			 writeAppearanceDefine (appearanceDefine, defineFile, binFilePackager);
		 }
	  }
	  
	  binFilePackager.close ();
   }
   
   
   function writePropertyDefineBlockList (propertyDefineBlockList, binFilePackager)
   {
      binFilePackager.writeShort ( getPropertyDefinesCountInBlockList (propertyDefineBlockList) );
      
      binFilePackager.writeShort (propertyDefineBlockList.size ());
	   
	   for (var propertyDefineBlockID = 0; propertyDefineBlockID < propertyDefineBlockList.size (); ++ propertyDefineBlockID)
	   {
	      var propertyDefineBlock = propertyDefineBlockList.get (propertyDefineBlockID);
			
	      var propertyDefineBlockName = propertyDefineBlock.getName ();
			
	      binFilePackager.writeUTF (propertyDefineBlockName);
			
	      var propertyDefines = propertyDefineBlock.getPropertyDefines ();
		
		  binFilePackager.writeShort (propertyDefines.size ());
		  
	      for (var propertyDefineID = 0; propertyDefineID < propertyDefines.size (); ++ propertyDefineID)
	      {
		     var propertyDefine = propertyDefines.get (propertyDefineID);
			   
			 var propertyName = propertyDefine.getName ();
			 var propertyType = propertyDefine.getValueType ();
			 var propertyTypeID = _PropertyTypeCollector.getObjectIndex (propertyType);
			 
			 binFilePackager.writeUTF (propertyName);
			 binFilePackager.writeShort (propertyTypeID);
	      }
	   }
   }
   
   function getPropertyDefinesCountInBlockList (propertyDefineBlockList)
   {
      var count = 0;
	   for (var propertyDefineBlockID = 0; propertyDefineBlockID < propertyDefineBlockList.size (); ++ propertyDefineBlockID)
	   {
	      var propertyDefineBlock = propertyDefineBlockList.get (propertyDefineBlockID);
	      var propertyDefines = propertyDefineBlock.getPropertyDefines ();
		
			count += propertyDefines.size ();
	   }
	   
	   return count;
   }
   
   function writeAppearanceDefine (appearanceDefine, defineFile, binFilePackager)
   {
		var appearanceName = appearanceDefine.getName ();
		var appearanceType = appearanceDefine.getType ();
      var appearanceTypeID = _AppearanceTypeCollector.getObjectIndex (appearanceType);
		
		var paramList = appearanceDefine.getParameters ();
		var paramTable = paramList2ParamTable (paramList);
      
      binFilePackager.writeShort (appearanceTypeID);
		
		if (appearanceType.equals (AppearanceFactory.AppearanceType_Sprite2d))
		{
		   var sprite2dFilePath = paramTable.get ("sprite2d_file");
		   var modelName = paramTable.get ("model_name");
		   var animationName = paramTable.get ("animation_name");
         
         var fullFilePath = FileUtil.getFullPathFilename(sprite2dFilePath, defineFile.getHostFilename());
         var sprite2dFile = FileCache.getSprite2dFile (fullFilePath);
         var animatedModuleGroup = sprite2dFile.parseNodePath(modelName);
         var animatedModule = animatedModuleGroup.getChild (animationName);
         
         var relativeFilePath = FileUtil.getRelativePathFilename (fullFilePath, defineFile.getHostFilename());
         
         binFilePackager.writeUTF (relativeFilePath);
         binFilePackager.writeShort (animatedModuleGroup.getIndex ());
         binFilePackager.writeShort (animatedModule.getIndex ());
		}
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Background2d))
		{
		   var sprite2dFilePath = paramTable.get ("sprite2d_file");
		   var backgroundName = paramTable.get ("background_name");
         
         var fullFilePath = FileUtil.getFullPathFilename(sprite2dFilePath, defineFile.getHostFilename());
         var sprite2dFile = FileCache.getSprite2dFile (fullFilePath);
         var tiled2dBackground = sprite2dFile.getTiledBackgroundSet().getChild (backgroundName);
         
         var relativeFilePath = FileUtil.getRelativePathFilename (fullFilePath, defineFile.getHostFilename());
        
         binFilePackager.writeUTF (relativeFilePath);
         binFilePackager.writeShort (tiled2dBackground.getIndex ());
		}
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Box2d))
		{
		   var border_color = paramTable.get ("border_color");
         var border_color_value = MiscUtil.parseInt(border_color, 0);
		   var filled_color = paramTable.get ("filled_color");
         var filled_color_value = MiscUtil.parseInt(border_color, 0);
         
         binFilePackager.writeInt (border_color_value);
         //binFilePackager.writeInt (filled_color_value);
		}
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Circle))
		{
		   var border_color = paramTable.get ("border_color");
         var border_color_value = MiscUtil.parseInt(border_color, 0);
		   var filled_color = paramTable.get ("filled_color");
         var filled_color_value = MiscUtil.parseInt(border_color, 0);
         
         binFilePackager.writeInt (border_color_value);
         //binFilePackager.writeInt (filled_color_value);
		}
		else if (appearanceType.equals (AppearanceFactory.AppearanceType_Line2d))
		{
		   var color = paramTable.get ("color");
         var color_value = MiscUtil.parseInt(color, 0);
         
         binFilePackager.writeInt (color_value);
		}
   }
   
   function paramList2ParamTable (paramList)
   {
      var paramTable = new Hashtable ();
      for (var paramID=0; paramID < paramList.size (); ++ paramID)
	   {
	     var param = paramList.get (paramID);
		  paramTable.put (param.getName (), param.getStringValue ()); 
	   }
     
      return paramTable;
   }
   
   function writePropertyList (propertyList, binFilePackager)
   {
      binFilePackager.writeShort (propertyList.size ());
      for (var propertyID=0; propertyID < propertyList.size (); ++ propertyID)
	  {
	     var property = propertyList.get (propertyID);
	     writeProperty (property, binFilePackager);
	  }
   }
   
   function writeProperty (property, binFilePackager)
   {
      var propertyType = property.getValueType ();
	  var valueComponent = property.getValueComponent ();
	  var propertyValue = property.getValue ();
	  
	  if (propertyType.equals (PropertyFactory.ValueType_Number))
	  {
	     //binFilePackager.writeInt (propertyValue.intValue ());
	     binFilePackager.writeFloat (propertyValue.floatValue ());
	  }
	  else if (propertyType.equals (PropertyFactory.ValueType_String))
	  {
	     binFilePackager.writeUTF (propertyValue);
	  }
	  else if (propertyType.equals (PropertyFactory.ValueType_Items))
	  {
	     //if (valueComponent.isMultipalSelectionsAllowed ())
		 //{
		 //}
		 //else
		    binFilePackager.writeShort (valueComponent.getSelectedIndex ());
	  }
	  else if (propertyType.equals (PropertyFactory.ValueType_EntityRef))
	  {
	     if (propertyValue == null)
		    binFilePackager.writeShort (-1);
	     else
		    binFilePackager.writeShort (propertyValue.getIndex ());
	  }
	  else if (propertyType.equals (PropertyFactory.ValueType_Boolean))
	  {
	     binFilePackager.writeByte (propertyValue.booleanValue () ? 1 : 0);
	  }
   }
   
   function writeDefineCodeFile (defineFile, filename)
   {
      println ("  - " + filename);
      
      var codeFileWriter = new CodeFileWriter_ActionScript (filename);
      
      {
         var packageName = "game.res";
         var className = FileUtil.getFilenameWithoutExt (filename);
         codeFileWriter.writePackageHead (packageName);
         {
            codeFileWriter.writeClassHead (className);
            {
               writeCollectorObjectIDs (_ActorTypeCollector,      "ActorType_",       codeFileWriter);
               writeCollectorObjectIDs (_AppearanceTypeCollector, "AppearanceType_",  codeFileWriter);
               writeCollectorObjectIDs (_PropertyTypeCollector,   "PropertyType_",    codeFileWriter);
               writeCollectorObjectIDs (_FileTypeCollector,       "FileType_",        codeFileWriter);
            }
            codeFileWriter.writeClassTail (className);
         }
         codeFileWriter.writePackageTail (packageName);
      }
      
      codeFileWriter.close ();
      
      // 
		var codeFilePath = FileUtil.getFullPathFilename ("kTemplate.as", _ResCompiledDir);
      writeTemplateCodeFile (defineFile, codeFilePath);
   }
   
   function writeTemplateCodeFile (defineFile, filename)
   {
      println ("  - " + filename);
      
      var codeFileWriter = new CodeFileWriter_ActionScript (filename);
      
      {
         var packageName = "game.res";
         var className = FileUtil.getFilenameWithoutExt (filename);
         codeFileWriter.writePackageHead (packageName);
         {
            codeFileWriter.writeClassHead (className);
            
            var actorTemplateSet = defineFile.getActorTemplateSet ();
            {
               var _TemplateCollector        = new ObjectCollector ();
               for (var templateID = 0; templateID < actorTemplateSet.getChildrenCount (); ++ templateID)
            	{
                  var actorTemplate = actorTemplateSet.getChildByIndex (templateID);
                  _TemplateCollector.addObject (actorTemplate.getName ());
               }

               writeCollectorObjectIDs (_TemplateCollector,      "TemplateID_",       codeFileWriter);
            }
            
            for (var templateID = 0; templateID < actorTemplateSet.getChildrenCount (); ++ templateID)
            {
               var actorTemplate = actorTemplateSet.getChildByIndex (templateID);
               var templateName = actorTemplate.getName ();
               
               codeFileWriter.writeTextLine ("// --------------- " + templateName);
               codeFileWriter.writeNewLines (1);
               templateName = templateName.replace (" ", "_");
               codeFileWriter.incIndents ();
               {
                  var _TemplatePropertyDefineCollector        = new ObjectCollector ();
                  var templatePropertyDefines = actorTemplate.getTemplatePropertyDefines ();               
            	   for (var propertyDefineBlockID = 0; propertyDefineBlockID < templatePropertyDefines.size (); ++ propertyDefineBlockID)
            	   {
            	      var propertyDefineBlock = templatePropertyDefines.get (propertyDefineBlockID);         			
            	      var propertyDefineBlockName = propertyDefineBlock.getName ();         			
            	      var propertyDefines = propertyDefineBlock.getPropertyDefines ();
            	      for (var propertyDefineID = 0; propertyDefineID < propertyDefines.size (); ++ propertyDefineID)
            	      {
                        var propertyDefine = propertyDefines.get (propertyDefineID);
                        var propertyName = propertyDefine.getName ();
                        propertyName = propertyName.replace (" ", "_");
                        
                        _TemplatePropertyDefineCollector.addObject (propertyName);
            	      }
                  }
                  
                  writeCollectorObjectIDs (_TemplatePropertyDefineCollector,      "TCP_" + actorTemplate.getName () + "_",       codeFileWriter);
                  
                  //
                  var _InstancePropertyDefineCollector        = new ObjectCollector ();
                  var instancePropertyDefines = actorTemplate.getInstancePropertyDefines ();
            	   for (var propertyDefineBlockID = 0; propertyDefineBlockID < instancePropertyDefines.size (); ++ propertyDefineBlockID)
            	   {
            	      var propertyDefineBlock = instancePropertyDefines.get (propertyDefineBlockID);         			
            	      var propertyDefineBlockName = propertyDefineBlock.getName ();         			
            	      var propertyDefines = propertyDefineBlock.getPropertyDefines ();
            	      for (var propertyDefineID = 0; propertyDefineID < propertyDefines.size (); ++ propertyDefineID)
            	      {
                        var propertyDefine = propertyDefines.get (propertyDefineID);
                        var propertyName = propertyDefine.getName ();
                        propertyName = propertyName.replace (" ", "_");
                        
                        _InstancePropertyDefineCollector.addObject (propertyName);
            	      }
                  }
                  
                  writeCollectorObjectIDs (_InstancePropertyDefineCollector,      "ICP_" + actorTemplate.getName () + "_",       codeFileWriter);
                  
                  //
                  var _AppearanceDefineCollector        = new ObjectCollector ();
                  var appearanceDefines = actorTemplate.getAppearanceDefines ();
            	   for (var appearanceDefineID = 0; appearanceDefineID < appearanceDefines.size (); ++ appearanceDefineID)
            	   {
            	      var appearanceDefine = appearanceDefines.get (appearanceDefineID);         			
            	      var appearanceDefineName = appearanceDefine.getName ();
                     appearanceDefineName = appearanceDefineName.replace (" ", "_");
                     _AppearanceDefineCollector.addObject (appearanceDefineName);
                  }
                  
                  writeCollectorObjectIDs (_AppearanceDefineCollector,      "Appearance_" + actorTemplate.getName () + "_",       codeFileWriter);
               }
               codeFileWriter.decIndents ();
            }
            codeFileWriter.writeClassTail (className);
         }
         codeFileWriter.writePackageTail (packageName);
      }
      
      codeFileWriter.close ();
   }
   
   function writeCollectorObjectIDs (collector, prefix, codeFileWriter)
   {
      codeFileWriter.writeTextLine ("// " + prefix);
      for (var objectID = 0; objectID < collector.getObjectsCount (); ++ objectID)
      {
         codeFileWriter.writeConstIntegerVariable (prefix + collector.getObjectAt (objectID), objectID);
      }      
      codeFileWriter.writeNewLines (2);
   }
   
   function packFiles ()
   {
      println ("Packed Files:");
	  
	   var binFilePackager = new BinaryFilePackager ( FileUtil.getFullPathFilename ("res.bin", _ResCompiledDir) );
      
	   binFilePackager.writeInt (_PackedFileInfoList.size ());
	   
      for (var fileID=0; fileID < _PackedFileInfoList.size (); ++ fileID)
      {
         var fileinfo = _PackedFileInfoList.get(fileID);
         
	      var gamepath = fileinfo.gamePath;
	      var fileType = fileinfo.fileType;
	      var fileTypeID = _FileTypeCollector.getObjectIndex (fileType);
         
         binFilePackager.writeUTF (gamepath);         
         binFilePackager.writeShort (fileTypeID);         
      }
	  
      binFilePackager.beginDataBlcoksWithOffsetTable (_PackedFileInfoList.size ());
      
      for (var fileID=0; fileID < _PackedFileInfoList.size (); ++ fileID)
      {
         var fileinfo = _PackedFileInfoList.get(fileID);
	  
	      var resPath = fileinfo.resPath;
         
	      var gamepath = fileinfo.gamePath;
	      var fileType = fileinfo.fileType;
	      var fileTypeID = _FileTypeCollector.getObjectIndex (fileType);  
         
	      println ("- res file: " + resPath);
	      println ("  - game path: " + gamepath);
	      println ("  - file type: " + fileType + " (" + fileTypeID + ")");
         
         binFilePackager.beginDataBlock ();
         if (fileType.equals (kFileType_Sound))
            ; // now sound files are seperated with game res data package for limitation of ActionScript 3.0
         else
            binFilePackager.writeFile (resPath);
         binFilePackager.endDataBlcok ();
      }
      
      binFilePackager.endDataBlcoksWithOffsetTable ();
      
      binFilePackager.close ();
   }
   
   function copySoundFiles ()
   {
  	  for (var fileID=0; fileID < _SoundFilesToBePacked.length; fileID ++)
     {
			var binFilename     = FileUtil.getFullPathFilename (_SoundFilesToBePacked [fileID], _ResBaseDir);
         var compileFilename = FileUtil.getFullPathFilename (_SoundFilesToBePacked [fileID], _ResCompiledDir);
         
         var binFilePackager = new BinaryFilePackager (compileFilename);
         binFilePackager.writeFile (binFilename);
         binFilePackager.close ();
     }
   }

//=================================================================
// main entry point
//=================================================================

   collectActorTypes ();
   collectAppearanceTypes ();
   collectPropertyTypes ();
   collectFileTypes ();


println ("--------------- parse arguments --------------");

   
   for (var argID=0; argID < arguments.length; argID ++)
   {
      var pos = arguments[argID].indexOf ("=");
      if (pos < 0)
      {
      }
      else
      {
        var paramName  = arguments[argID].substring (0, pos);
        var paramValue = arguments[argID].substring (pos + 1);
        
        if (paramName.equals ("res_base_dir"))
        {
           _ResBaseDir = FileUtil.getCanonicalPathFileName (paramValue);
		   
            println ("_ResBaseDir=" + _ResBaseDir);
        }
        else if (paramName.equals ("res_compiled_dir"))
        {
           _ResCompiledDir = FileUtil.getCanonicalPathFileName (paramValue);
		   
            println ("_ResCompiledDir=" + _ResCompiledDir);
        }
        else if (paramName.equals ("game_mode"))
        {
           _GameMode = paramValue;
           
            println ("_GameMode=" + _GameMode);
        }
      }
   }
   
println ("--------------- parse files --------------");

   var levelFiles;
   

   if (_GameMode.equals ("puzzle"))
      levelFiles = _LevelFilesToBePacked_puzzle;
   else if (_GameMode.equals ("domino"))
      levelFiles = _LevelFilesToBePacked_domino;
   else //if (_GameMode.equals ("decathlon"))
      levelFiles = _LevelFilesToBePacked_decathlon;
  

   println ("Level Files:");
   for (var fileID=0; fileID < levelFiles.length; fileID ++)
   {
      println ("- parsing: " + levelFiles [fileID]);
	   FileCache.getLevelFile (FileUtil.getFullPathFilename (levelFiles [fileID], _ResBaseDir));
   }


println ("--------------- collect res files --------------");

   collectPackedFiles ();
   
println ("--------------- package files --------------");

   packFiles ();
   
   copySoundFiles ();
   
}


