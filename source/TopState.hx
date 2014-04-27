package ;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;
import particle.*;

enum TopStateMode {
	TopStateMode_Gameplay;
	TopStateMode_Fadeout_To_Game;
	TopStateMode_Fadein_From_Game;
	TopStateMode_Fadeout_To_Next;
}

class TopState extends FlxState {
	
	var _player:FlxSprite;
	var _mom:FlxSprite;
	var _baby:FlxSprite;
	
	var _mom_speechbubble:FlxGroup;
	var _mom_speechbubble_fishreq:FlxText;
	
	var _particles:FlxGroup;
	
	var _ui:GameUI;
	var _mode:TopStateMode;
	
	override public function create():Void {
		super.create();
		
		var bg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/top/top_bg.png"));
		this.add(bg);
		
		_mom = new FlxSprite(FlxG.width * 0.2, FlxG.height * 0.65);
		_mom.loadGraphic(Assets.getBitmapData("assets/images/top/mom_anim.png"),true,45,83);
		_mom.animation.add("barf", [1, 0], 10);
		_mom.animation.add("stand", [1]);
		_mom.animation.play("stand");
		this.add(_mom);
		
		_player = new FlxSprite(FlxG.width * 0.64, FlxG.height * 0.65);
		_player.loadGraphic(Assets.getBitmapData("assets/images/top/player_anim.png"), true, 45, 85);
		_player.animation.add("stand", [2]);
		_player.animation.add("walk", [2, 1],25);
		_player.animation.add("barf", [2, 0],10);
		_player.animation.play("stand");
		this.add(_player);
		
		/*
		_baby = new FlxSprite(FlxG.width * 0.1, FlxG.height * 0.65 + 49);
		_baby.loadGraphic(Assets.getBitmapData("assets/images/top/baby_anim.png"),true,26,34);
		_baby.animation.add("barf", [1, 0], 10);
		_baby.animation.add("stand", [1]);
		_baby.animation.play("barf");
		this.add(_baby);
		*/
		
		_mom_speechbubble = new FlxGroup();
		this.add(_mom_speechbubble);
		
		var mom_speechbubble_bg = new FlxSprite(_mom.x-20, _mom.y-65, Assets.getBitmapData("assets/images/fx/speechbubble.png"));
		mom_speechbubble_bg.alpha = 0.7;
		_mom_speechbubble.add(mom_speechbubble_bg);
		
		var fishicon = new FlxSprite(mom_speechbubble_bg.x + 15,mom_speechbubble_bg.y+10,Assets.getBitmapData("assets/images/char/goldfish.png"));
		_mom_speechbubble.add(fishicon);
		
		_mom_speechbubble_fishreq = new FlxText(fishicon.x + 20, fishicon.y, 0, "");
		_mom_speechbubble_fishreq.color = 0xFF000000;
		_mom_speechbubble.add(_mom_speechbubble_fishreq);
		_mom_speechbubble.visible = false;
		
		var pressz = new FlxText(mom_speechbubble_bg.x + 5, mom_speechbubble_bg.y + 30, 0, "Press Z", 15);
		pressz.color = 0xFF000000;
		_mom_speechbubble.add(pressz);
		
		_particles = new FlxGroup();
		this.add(_particles);
		
		_ui = new GameUI();
		this.add(_ui);
		_ui.game_update();
		
		_mode = TopStateMode_Fadein_From_Game;
		_ui._fadeout.alpha = 1;
	}
	
	var _player_barf_ct = 0;
	override public function update():Void {
		super.update();
		if (_mode == TopStateMode_Fadein_From_Game) {
			_ui._fadeout.alpha -= 0.05;
			if (_ui._fadeout.alpha <= 0) {
				_mode = TopStateMode_Gameplay;
			}
			
		} else if (_mode == TopStateMode_Fadeout_To_Game) {
			_player.animation.play("stand");
			_ui._fadeout.alpha += 0.05;
			if (_ui._fadeout.alpha >= 1) {
				FlxG.switchState(new GameState());
			}
			
		} else if (_mode == TopStateMode_Fadeout_To_Next) {
			
		} else if (_mode == TopStateMode_Gameplay) {
			_ui.game_update();
			_mom_speechbubble_fishreq.text = "x " + Stats._required_fish;
			
			for (i in _particles.members) if (i.alive) cast(i, BaseParticle).game_update();
			
			if (FlxG.keys.pressed.LEFT && _player.x > FlxG.width * 0.3) {
				_player.x -= 5; 
				_player.flipX = false;
				_player.animation.play("walk");
				
			} else if (FlxG.keys.pressed.RIGHT && _player.x < FlxG.width * 0.675 ) {
				_player.x += 5;
				_player.flipX = true;
				_player.animation.play("walk");
				
			} else if (_player_barf_ct > 0) {
				_player_barf_ct--;
				_player.animation.play("barf");
				
			} else {
				_player.animation.play("stand");
			}
			
			if (_particles.countLiving() > 0) {
				_mom.animation.play("barf");
			} else {
				_mom.animation.play("stand");
			}
			
			if (_player.x < FlxG.width * 0.4) {
				_mom_speechbubble.visible = true;
				
				if (FlxG.keys.justPressed.Z && Stats._current_fish > 0 && Stats._required_fish > 0) {
					BarfFishParticle.cons_particle(_particles).init(
						Util.flxpt(_player.x, _player.y), 
						Util.flxpt2(_mom.x + 25, _mom.y + 10)
					);
					Stats._current_fish--;
					Stats._required_fish--;
					_player_barf_ct = 10;
				}
				
			} else {
				_mom_speechbubble.visible = false;
			}
			
			if (_player.x > FlxG.width * 0.67) {
				_mode = TopStateMode_Fadeout_To_Game;
			}
		}
	}
}