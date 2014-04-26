package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.text.Font;
import flash.media.Sound;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Unserializer;
import openfl.Assets;

#if (flash || js)
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLLoader;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(flash.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public static var className (default, null) = new Map <String, Dynamic> ();
	public static var path (default, null) = new Map <String, String> ();
	public static var type (default, null) = new Map <String, AssetType> ();
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/images/bottom/bottom_bg.png", __ASSET__assets_images_bottom_bottom_bg_png);
		type.set ("assets/images/bottom/bottom_bg.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/bottom/bottom_fg.png", __ASSET__assets_images_bottom_bottom_fg_png);
		type.set ("assets/images/bottom/bottom_fg.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/goldfish.png", __ASSET__assets_images_char_goldfish_png);
		type.set ("assets/images/char/goldfish.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/jellyfish.png", __ASSET__assets_images_char_jellyfish_png);
		type.set ("assets/images/char/jellyfish.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/orca.png", __ASSET__assets_images_char_orca_png);
		type.set ("assets/images/char/orca.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/player.png", __ASSET__assets_images_char_player_png);
		type.set ("assets/images/char/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/seal.png", __ASSET__assets_images_char_seal_png);
		type.set ("assets/images/char/seal.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/top_character_mom.png", __ASSET__assets_images_char_top_character_mom_png);
		type.set ("assets/images/char/top_character_mom.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/top_character_player.png", __ASSET__assets_images_char_top_character_player_png);
		type.set ("assets/images/char/top_character_player.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/char/tuna.png", __ASSET__assets_images_char_tuna_png);
		type.set ("assets/images/char/tuna.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/fx/enemy_bullet.png", __ASSET__assets_images_fx_enemy_bullet_png);
		type.set ("assets/images/fx/enemy_bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/fx/enemy_explosion.png", __ASSET__assets_images_fx_enemy_explosion_png);
		type.set ("assets/images/fx/enemy_explosion.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/fx/player_bullet.png", __ASSET__assets_images_fx_player_bullet_png);
		type.set ("assets/images/fx/player_bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/images/top/top_bg.png", __ASSET__assets_images_top_top_bg_png);
		type.set ("assets/images/top/top_bg.png", Reflect.field (AssetType, "image".toUpperCase ()));
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
		
		
		#elseif html5
		
		addExternal("assets/data/data-goes-here.txt", "text", "assets/data/data-goes-here.txt");
		addExternal("assets/images/bottom/bottom_bg.png", "image", "assets/images/bottom/bottom_bg.png");
		addExternal("assets/images/bottom/bottom_fg.png", "image", "assets/images/bottom/bottom_fg.png");
		addExternal("assets/images/char/goldfish.png", "image", "assets/images/char/goldfish.png");
		addExternal("assets/images/char/jellyfish.png", "image", "assets/images/char/jellyfish.png");
		addExternal("assets/images/char/orca.png", "image", "assets/images/char/orca.png");
		addExternal("assets/images/char/player.png", "image", "assets/images/char/player.png");
		addExternal("assets/images/char/seal.png", "image", "assets/images/char/seal.png");
		addExternal("assets/images/char/top_character_mom.png", "image", "assets/images/char/top_character_mom.png");
		addExternal("assets/images/char/top_character_player.png", "image", "assets/images/char/top_character_player.png");
		addExternal("assets/images/char/tuna.png", "image", "assets/images/char/tuna.png");
		addExternal("assets/images/fx/enemy_bullet.png", "image", "assets/images/fx/enemy_bullet.png");
		addExternal("assets/images/fx/enemy_explosion.png", "image", "assets/images/fx/enemy_explosion.png");
		addExternal("assets/images/fx/player_bullet.png", "image", "assets/images/fx/player_bullet.png");
		addExternal("assets/images/images-go-here.txt", "text", "assets/images/images-go-here.txt");
		addExternal("assets/images/top/top_bg.png", "image", "assets/images/top/top_bg.png");
		addExternal("assets/music/music-goes-here.txt", "text", "assets/music/music-goes-here.txt");
		addExternal("assets/sounds/sounds-go-here.txt", "text", "assets/sounds/sounds-go-here.txt");
		addExternal("assets/sounds/beep.mp3", "music", "assets/sounds/beep.mp3");
		addExternal("assets/sounds/flixel.mp3", "music", "assets/sounds/flixel.mp3");
		
		
		#else
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<AssetData> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							path.set (asset.id, asset.path);
							type.set (asset.id, asset.type);
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest");
				
			}
			
		} catch (e:Dynamic) {
			
			trace ("Warning: Could not load asset manifest");
			
		}
		
		#end
		
	}
	
	
	#if html5
	private function addEmbed(id:String, kind:String, value:Dynamic):Void {
		className.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	
	
	private function addExternal(id:String, kind:String, value:String):Void {
		path.set(id, value);
		type.set(id, Reflect.field(AssetType, kind.toUpperCase()));
	}
	#end
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = DefaultAssetLibrary.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif openfl_html5
		
		return null;
		
		#elseif js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_images_bottom_bottom_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_bottom_bottom_fg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_goldfish_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_jellyfish_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_orca_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_seal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_top_character_mom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_top_character_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_char_tuna_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_fx_enemy_bullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_fx_enemy_explosion_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_fx_player_bullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_images_top_top_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5























#end
