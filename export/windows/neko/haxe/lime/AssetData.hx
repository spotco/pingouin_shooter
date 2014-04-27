package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/bottom/bottom_bg.png", "assets/images/bottom/bottom_bg.png");
			type.set ("assets/images/bottom/bottom_bg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/bottom/bottom_fg.png", "assets/images/bottom/bottom_fg.png");
			type.set ("assets/images/bottom/bottom_fg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/big_jellyfish.png", "assets/images/char/big_jellyfish.png");
			type.set ("assets/images/char/big_jellyfish.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/goldfish.png", "assets/images/char/goldfish.png");
			type.set ("assets/images/char/goldfish.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/jellyfish.png", "assets/images/char/jellyfish.png");
			type.set ("assets/images/char/jellyfish.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/orca.png", "assets/images/char/orca.png");
			type.set ("assets/images/char/orca.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/player.png", "assets/images/char/player.png");
			type.set ("assets/images/char/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/seal.png", "assets/images/char/seal.png");
			type.set ("assets/images/char/seal.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/top_character_mom.png", "assets/images/char/top_character_mom.png");
			type.set ("assets/images/char/top_character_mom.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/top_character_player.png", "assets/images/char/top_character_player.png");
			type.set ("assets/images/char/top_character_player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/tuna.png", "assets/images/char/tuna.png");
			type.set ("assets/images/char/tuna.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/1up.png", "assets/images/fx/1up.png");
			type.set ("assets/images/fx/1up.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/enemy_bullet.png", "assets/images/fx/enemy_bullet.png");
			type.set ("assets/images/fx/enemy_bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/enemy_explosion.png", "assets/images/fx/enemy_explosion.png");
			type.set ("assets/images/fx/enemy_explosion.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/player_bullet.png", "assets/images/fx/player_bullet.png");
			type.set ("assets/images/fx/player_bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/plusen.png", "assets/images/fx/plusen.png");
			type.set ("assets/images/fx/plusen.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/speechbubble.png", "assets/images/fx/speechbubble.png");
			type.set ("assets/images/fx/speechbubble.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/logo.png", "assets/images/logo.png");
			type.set ("assets/images/logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player_hitbox.png", "assets/images/player_hitbox.png");
			type.set ("assets/images/player_hitbox.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/splash.png", "assets/images/splash.png");
			type.set ("assets/images/splash.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ss_1.png", "assets/images/ss_1.png");
			type.set ("assets/images/ss_1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ss_2.png", "assets/images/ss_2.png");
			type.set ("assets/images/ss_2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ss_3.png", "assets/images/ss_3.png");
			type.set ("assets/images/ss_3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/baby_anim.png", "assets/images/top/baby_anim.png");
			type.set ("assets/images/top/baby_anim.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/mom_anim.png", "assets/images/top/mom_anim.png");
			type.set ("assets/images/top/mom_anim.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/player_anim.png", "assets/images/top/player_anim.png");
			type.set ("assets/images/top/player_anim.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/top_bg.png", "assets/images/top/top_bg.png");
			type.set ("assets/images/top/top_bg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/top_crowd.png", "assets/images/top/top_crowd.png");
			type.set ("assets/images/top/top_crowd.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/top_crowd_medium.png", "assets/images/top/top_crowd_medium.png");
			type.set ("assets/images/top/top_crowd_medium.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/top/top_smallcrowd.png", "assets/images/top/top_smallcrowd.png");
			type.set ("assets/images/top/top_smallcrowd.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
