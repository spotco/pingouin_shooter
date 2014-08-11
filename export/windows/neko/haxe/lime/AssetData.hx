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
			path.set ("assets/images/char/player_top/main_character_default.plist", "assets/images/char/player_top/main_character_default.plist");
			type.set ("assets/images/char/player_top/main_character_default.plist", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/char/player_top/main_character_default.png", "assets/images/char/player_top/main_character_default.png");
			type.set ("assets/images/char/player_top/main_character_default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/seal.png", "assets/images/char/seal.png");
			type.set ("assets/images/char/seal.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/top_character_mom.png", "assets/images/char/top_character_mom.png");
			type.set ("assets/images/char/top_character_mom.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/top_character_player.png", "assets/images/char/top_character_player.png");
			type.set ("assets/images/char/top_character_player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/char/tuna.png", "assets/images/char/tuna.png");
			type.set ("assets/images/char/tuna.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/controls_arrowzx.png", "assets/images/controls_arrowzx.png");
			type.set ("assets/images/controls_arrowzx.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/controls_bubble.png", "assets/images/controls_bubble.png");
			type.set ("assets/images/controls_bubble.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/controls_wasdmouse.png", "assets/images/controls_wasdmouse.png");
			type.set ("assets/images/controls_wasdmouse.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/1up.png", "assets/images/fx/1up.png");
			type.set ("assets/images/fx/1up.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/enemy_bullet.png", "assets/images/fx/enemy_bullet.png");
			type.set ("assets/images/fx/enemy_bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/enemy_explosion.png", "assets/images/fx/enemy_explosion.png");
			type.set ("assets/images/fx/enemy_explosion.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/heart.png", "assets/images/fx/heart.png");
			type.set ("assets/images/fx/heart.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/player_bullet.png", "assets/images/fx/player_bullet.png");
			type.set ("assets/images/fx/player_bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/plusen.png", "assets/images/fx/plusen.png");
			type.set ("assets/images/fx/plusen.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fx/speechbubble.png", "assets/images/fx/speechbubble.png");
			type.set ("assets/images/fx/speechbubble.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
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
			path.set ("assets/music/bottom1.mp3", "assets/music/bottom1.mp3");
			type.set ("assets/music/bottom1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/music/bottom2.mp3", "assets/music/bottom2.mp3");
			type.set ("assets/music/bottom2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/music/bottom3.mp3", "assets/music/bottom3.mp3");
			type.set ("assets/music/bottom3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/music/bottom4.mp3", "assets/music/bottom4.mp3");
			type.set ("assets/music/bottom4.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/music/ss_3.png", "assets/music/ss_3.png");
			type.set ("assets/music/ss_3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/top.mp3", "assets/music/top.mp3");
			type.set ("assets/music/top.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_bone_1.mp3", "assets/sounds/sfx_bone_1.mp3");
			type.set ("assets/sounds/sfx_bone_1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_bone_2.mp3", "assets/sounds/sfx_bone_2.mp3");
			type.set ("assets/sounds/sfx_bone_2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_bone_3.mp3", "assets/sounds/sfx_bone_3.mp3");
			type.set ("assets/sounds/sfx_bone_3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_bone_4.mp3", "assets/sounds/sfx_bone_4.mp3");
			type.set ("assets/sounds/sfx_bone_4.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_explosion.mp3", "assets/sounds/sfx_explosion.mp3");
			type.set ("assets/sounds/sfx_explosion.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_goal.mp3", "assets/sounds/sfx_goal.mp3");
			type.set ("assets/sounds/sfx_goal.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_hit.mp3", "assets/sounds/sfx_hit.mp3");
			type.set ("assets/sounds/sfx_hit.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_jump.mp3", "assets/sounds/sfx_jump.mp3");
			type.set ("assets/sounds/sfx_jump.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_powerup.mp3", "assets/sounds/sfx_powerup.mp3");
			type.set ("assets/sounds/sfx_powerup.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_spin.mp3", "assets/sounds/sfx_spin.mp3");
			type.set ("assets/sounds/sfx_spin.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_splash.mp3", "assets/sounds/sfx_splash.mp3");
			type.set ("assets/sounds/sfx_splash.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/sfx_wavebullet.mp3", "assets/sounds/sfx_wavebullet.mp3");
			type.set ("assets/sounds/sfx_wavebullet.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/shoot1.mp3", "assets/sounds/shoot1.mp3");
			type.set ("assets/sounds/shoot1.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/shoot2.mp3", "assets/sounds/shoot2.mp3");
			type.set ("assets/sounds/shoot2.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/shoot3.mp3", "assets/sounds/shoot3.mp3");
			type.set ("assets/sounds/shoot3.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/shoot_orca.mp3", "assets/sounds/shoot_orca.mp3");
			type.set ("assets/sounds/shoot_orca.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/shoot_player.mp3", "assets/sounds/shoot_player.mp3");
			type.set ("assets/sounds/shoot_player.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
