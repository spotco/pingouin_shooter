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
import bgdetail.*;

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
	
	var _top_penguins:FlxGroup = new FlxGroup();
	
	var _mom_speechbubble:FlxGroup;
	var _mom_speechbubble_fishreq:FlxText;
	
	var _heart:FlxSprite;
	
	var _particles:FlxGroup;
	
	var _ui:GameUI;
	var _mode:TopStateMode;
	
	var _controls_arrowzx:FlxSprite;
	var _controls_wasdmouse:FlxSprite;
	var _controls_text:FlxText;
	
	var _pressz:FlxText;
	
	override public function create():Void {
		super.create();
		FlxG.sound.playMusic(Assets.getMusic("assets/music/top.mp3"));
		instance = this;
		
		Stats._current_energy = Stats._max_energy;
		
		this.add(new FlxSprite(0,0,Assets.getBitmapData("assets/images/top/top_bg.png")));
		
		var eat_target_offset = Util.flxpt(0, 0);
		
		this.add(_top_penguins);
		if (Stats._stage == 0) {
			//this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_smallcrowd.png")));
			
			TopPenguin.cons(_top_penguins).init(300, 230).set_scale(0.6).set_opacity(0.8).set_wander_dx( 150);
			TopPenguin.cons(_top_penguins).init(400, 240).set_scale(0.65).set_opacity(0.8).set_wander_dx( -100);
			TopPenguin.cons(_top_penguins).init(500, 250).set_scale(0.7).set_opacity(0.8).set_wander_dx( -100);
			
			this.add(new FlxSprite(FlxG.width*0.2, FlxG.height*0.1, Assets.getBitmapData("assets/images/logo.png")));
			
			this.add(Util.cons_text(FlxG.width * 0.2, FlxG.height * 0.325, "Made by SPOTCO (spotcos.com) for LD29 Compo", 0xFF000000, 14));
			
			var bub = new FlxSprite(FlxG.width * 0.775, FlxG.height * 0.25, Assets.getBitmapData("assets/images/controls_bubble.png"));
			bub.alpha = 0.6;
			this.add(bub);
			this.add( Util.cons_text(FlxG.width * 0.775 + 5, FlxG.height * 0.25+5, "Control Mode:"));
			_controls_text = Util.cons_text(FlxG.width * 0.78 + 5, FlxG.height * 0.4, "Shoot: Z\nDash: X\nFocus: Shift\nMove:\n   Arrow keys");
			this.add(_controls_text);
			
			_controls_arrowzx = new FlxSprite(FlxG.width * 0.79, FlxG.height * 0.286+2, Assets.getBitmapData("assets/images/controls_arrowzx.png"));
			this.add(_controls_arrowzx);
			_controls_wasdmouse = new FlxSprite(FlxG.width * 0.855, FlxG.height * 0.286+2, Assets.getBitmapData("assets/images/controls_wasdmouse.png"));
			this.add(_controls_wasdmouse);
			
			_eat_target = cons_mom_penguin(FlxG.width * 0.2, FlxG.height * 0.65,this);
			
			eat_target_offset.x = -20;
			eat_target_offset.y = -65;
			
		} else if (Stats._stage == 1) {
			//this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_crowd.png")));
			_eat_target = cons_penguin_with_egg(FlxG.width * 0.2, FlxG.height * 0.65,this);
			
			eat_target_offset.x = -20;
			eat_target_offset.y = -65;
			
		} else if (Stats._stage == 2) {
			//this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_crowd.png")));
			var mom = cons_penguin(FlxG.width * 0.1, FlxG.height * 0.65,this);
			mom.flipX = true;
			this.add(mom);
			_eat_target = cons_baby(FlxG.width * 0.2, FlxG.height * 0.65 + 49,this);
			
			eat_target_offset.x = -30;
			eat_target_offset.y = -75;
			
		} else if (Stats._stage == 3) {
			//this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_crowd_medium.png")));
			_eat_target = cons_fledgling(FlxG.width * 0.2, FlxG.height * 0.65 + 49,this);
			
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
		
		_pressz = new FlxText(mom_speechbubble_bg.x + 5, mom_speechbubble_bg.y + 30, 0,"", 15);
		_pressz.color = 0xFF000000;
		_mom_speechbubble.add(_pressz);
		
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
		
		update_controls();
	}
	
	function update_controls():Void {
		if (Stats._control_mode == ControlMode_ARROWZX) {
			_pressz.text = "Press Z!";
			FlxG.mouse.visible = false;
			if (_controls_arrowzx == null) return;
			_controls_text.text = "Shoot: Z\nDash: X\nFocus: Shift\nMove:\n   Arrow keys";
		} else {
			_pressz.text = "  Click!";
			FlxG.mouse.visible = true;
			if (_controls_arrowzx == null) return;
			_controls_text.text = "Shoot: LMB\nDash: RMB\nFocus: Shift\nMove:\n   WASD";
		}
	}
	
	var _kill:Bool = false;
	var _heart_t:Float = 0;
	var _player_barf_ct = 0;
	override public function update():Void {
		super.update();
		if (_kill) return;
		
		if (_controls_arrowzx != null) {
			_controls_arrowzx.alpha = 0.3;
			_controls_wasdmouse.alpha = 0.3;
			if (Stats._control_mode == ControlMode_ARROWZX) {
				_controls_arrowzx.alpha = 1;
				
				if (FlxG.mouse.justPressed || FlxG.keys.justPressed.W || FlxG.keys.justPressed.A || FlxG.keys.justPressed.S|| FlxG.keys.justPressed.D) {
					Stats._control_mode = ControlMode_WASDMOUSE;
					update_controls();
				}
				
			} else {
				_controls_wasdmouse.alpha = 1;
				
				if (FlxG.keys.justPressed.Z || FlxG.keys.justPressed.X || FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.UP || FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.DOWN) {
					Stats._control_mode = ControlMode_ARROWZX;
					update_controls();
				}
				
			}
		}
		
		
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
			
			if (Util.move_left() && _player.x > FlxG.width * 0.3) {
				_player.x -= 5; 
				_player.flipX = false;
				_player.animation.play("walk");
				
			} else if (Util.move_right() && _player.x < FlxG.width * 0.675 ) {
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
			_feedct--;
			if (_player.x < FlxG.width * 0.4) {
				_mom_speechbubble.visible = true;
				
				if (Util.shoot() && _feedct <= 0 && Stats._current_fish > 0 && Stats._required_fish > 0) {
					Util.sfx("sfx_jump.mp3");
					_feedct = 4;
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
	var _feedct = 0;
	
	public static function cons_baby(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.1, FlxG.height * 0.65 + 49
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/baby_anim.png"),true,39,52);
		rtv.animation.add("barf", [1, 2, 3, 2], 15);
		rtv.animation.add("stand", [0]);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public static function cons_fledgling(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.1, FlxG.height * 0.65 + 49
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/fledgling_anim.png"),true,52,87);
		rtv.animation.add("barf", [1, 2, 3, 2], 15);
		rtv.animation.add("stand", [0]);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public static function cons_penguin_with_egg(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.2, FlxG.height * 0.65
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/mom_anim.png"),true,62,94);
		rtv.animation.add("barf", [5,6,7,6], 15);
		rtv.animation.add("stand", [4]);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public static function cons_mom_penguin(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.2, FlxG.height * 0.65
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/mom_anim.png"),true,62,94);
		rtv.animation.add("barf", [1,2,3,2], 15);
		rtv.animation.add("stand", [0]);
		rtv.animation.play("stand");
		g.add(rtv);
		return rtv;
	}
	
	public static function cons_penguin(x:Float,y:Float,g:FlxGroup):FlxSprite { //FlxG.width * 0.64, FlxG.height * 0.65
		var rtv = new FlxSprite(x,y);
		rtv.loadGraphic(Assets.getBitmapData("assets/images/top/player_anim.png"), true, 112, 130);
		rtv.animation.add("stand", [0]);
		rtv.animation.add("walk", [1,2,3,2], 15);
		rtv.animation.add("barf", [18,19,20,21],15);
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