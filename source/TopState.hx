package ;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import openfl.Assets;
import particle.*;

enum TopStateMode {
	TopStateMode_Gameplay;
	TopStateMode_Fadeout_To_Game;
	TopStateMode_Fadein_From_Game;
	TopStateMode_Fadeout_To_Next;
}

class TopState extends FlxState {
	
	public static var instance:TopState;
	
	var _player:FlxSprite;
	var _eat_target:FlxSprite;
	
	var _mom_speechbubble:FlxGroup;
	var _mom_speechbubble_fishreq:FlxText;
	
	var _heart:FlxSprite;
	
	var _particles:FlxGroup;
	
	var _ui:GameUI;
	var _mode:TopStateMode;
	
	override public function create():Void {
		super.create();
		FlxG.sound.playMusic(Assets.getMusic("assets/music/top.mp3"));
		instance = this;
		
		Stats._current_energy = Stats._max_energy;
		
		this.add(new FlxSprite(0,0,Assets.getBitmapData("assets/images/top/top_bg.png")));
		
		var eat_target_offset = Util.flxpt(0, 0);
		
		if (Stats._stage == 0) {
			this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_smallcrowd.png")));
			
			this.add(new FlxSprite(FlxG.width*0.2, FlxG.height*0.1, Assets.getBitmapData("assets/images/logo.png")));
			
			this.add(Util.cons_text(FlxG.width * 0.2, FlxG.height * 0.325, "Made by SPOTCO (spotcos.com) for LD29 Compo", 0xFF000000, 14));
			
			var bub = new FlxSprite(FlxG.width * 0.85, FlxG.height * 0.4, Assets.getBitmapData("assets/images/fx/speechbubble.png"));
			bub.alpha = 0.6;
			this.add(bub);
			this.add(Util.cons_text(FlxG.width * 0.85 + 5, FlxG.height * 0.4 + 5, "Shoot: Z\nDash: X\nMove:\n   Arrow keys"));
			
			_eat_target = cons_penguin(FlxG.width * 0.2, FlxG.height * 0.65,this);
			_eat_target.flipX  = true;
			
			eat_target_offset.x = -20;
			eat_target_offset.y = -65;
			
		} else if (Stats._stage == 1) {
			this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_crowd.png")));
			_eat_target = cons_penguin_with_egg(FlxG.width * 0.2, FlxG.height * 0.65,this);
			
			eat_target_offset.x = -20;
			eat_target_offset.y = -65;
			
		} else if (Stats._stage == 2) {
			this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_crowd.png")));
			var mom = cons_penguin(FlxG.width * 0.1, FlxG.height * 0.65,this);
			mom.flipX = true;
			this.add(mom);
			_eat_target = cons_baby(FlxG.width * 0.2, FlxG.height * 0.65 + 49,this);
			
			eat_target_offset.x = -30;
			eat_target_offset.y = -75;
			
		} else if (Stats._stage == 3) {
			this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_crowd_medium.png")));
			_eat_target = cons_baby(FlxG.width * 0.2, FlxG.height * 0.65 + 49,this);
			_eat_target.scale.set(1.3, 1.3);
			
			eat_target_offset.x = -30;
			eat_target_offset.y = -75;
			
		} else {
			Stats._stage = 0;
			Stats.set_stage_params();
			FlxG.switchState(new GameEndState());
			_kill = true;
			return;
		}
		
		_player = cons_penguin(FlxG.width * 0.64, FlxG.height * 0.65,this);
		
		
		_mom_speechbubble = new FlxGroup();
		this.add(_mom_speechbubble);
		
		var mom_speechbubble_bg = new FlxSprite(_eat_target.x+eat_target_offset.x, _eat_target.y+eat_target_offset.y, Assets.getBitmapData("assets/images/fx/speechbubble.png"));
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
		
		_heart = new FlxSprite(_eat_target.x +60, _eat_target.y - 65, Assets.getBitmapData("assets/images/fx/heart.png"));
		_heart.scale.set(0.5, 0.5);
		_heart.alpha = 0.6;
		_heart.visible = false;
		this.add(_heart);
		
		_ui = new GameUI();
		this.add(_ui);
		_ui.game_update();
		
		_mode = TopStateMode_Fadein_From_Game;
		_ui._fadeout.alpha = 1;
	}
	
	var _kill:Bool = false;
	var _heart_t:Float = 0;
	var _player_barf_ct = 0;
	override public function update():Void {
		super.update();
		if (_kill) return;
		_heart_t += 0.05;
		var sc = (Math.sin(_heart_t) + 1)/2 * 0.5 + 0.5;
		_heart.scale.set(sc, sc);
		
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
			_player.animation.play("stand");
			_eat_target.animation.play("stand");
			
			_ui.game_update();
			_mom_speechbubble.visible = false;
			_heart.visible = true;
			_heart.x = _eat_target.x + (_player.x - _eat_target.x) / 2;
			for (i in _particles.members) if (i.alive) cast(i, BaseParticle).game_update();
			if (_particles.countLiving() > 0) return;
			
			_ui._fadeout.alpha += 0.01;
			if (_ui._fadeout.alpha >= 1) {
				Stats._stage++;
				Stats.set_stage_params();
				FlxG.switchState(new TopState());
			}
			
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
				_eat_target.animation.play("barf");
			} else {
				_eat_target.animation.play("stand");
			}
			
			if (_player.x < FlxG.width * 0.4) {
				_mom_speechbubble.visible = true;
				
				if (FlxG.keys.justPressed.Z && Stats._current_fish > 0 && Stats._required_fish > 0) {
					Util.sfx("sfx_jump.mp3");
					var eat_target_offset = new FlxPoint(0, 0);
					if (Stats._stage == 0 || Stats._stage == 1) {
						eat_target_offset.x = 25;
						eat_target_offset.y = 10;
					} else if (Stats._stage == 2) {
						eat_target_offset.x = 15;
						eat_target_offset.y = 0;
					} else if (Stats._stage == 3) {
						eat_target_offset.x = 15;
						eat_target_offset.y = 0;
					}
					
					BarfFishParticle.cons_particle(_particles).init(
						Util.flxpt(_player.x, _player.y), 
						Util.flxpt2(_eat_target.x + eat_target_offset.x, _eat_target.y + eat_target_offset.y)
					);
					Stats._current_fish--;
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
	
	public static function cons_baby(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.1, FlxG.height * 0.65 + 49
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/baby_anim.png"),true,26,34);
		rtv.animation.add("barf", [0, 1], 10);
		rtv.animation.add("stand", [1]);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public static function cons_penguin_with_egg(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.2, FlxG.height * 0.65
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/mom_anim.png"),true,45,83);
		rtv.animation.add("barf", [1, 0], 10);
		rtv.animation.add("stand", [1]);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public static function cons_penguin(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.64, FlxG.height * 0.65
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/player_anim.png"), true, 45, 85);
		rtv.animation.add("stand", [2]);
		rtv.animation.add("walk", [2, 1],25);
		rtv.animation.add("barf", [0, 2], 10);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public function fish_feed_anim_complete():Void {
		Stats._required_fish = cast(Math.max(0,Stats._required_fish-1),Int);
		if (Stats._required_fish <= 0 && _mode != TopStateMode_Fadeout_To_Next) {
			Util.sfx("sfx_goal.mp3");
			_heart.x = _eat_target.x + (_player.x - _eat_target.x) / 2;
			_mode = TopStateMode_Fadeout_To_Next;
			_heart_t = 0;
		}
	}
}