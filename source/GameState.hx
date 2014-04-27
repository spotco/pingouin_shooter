package ;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxVector;
import openfl.Assets;
import enemy.*;
import particle.*;
import pickup.BasePickup;

enum GameStateMode {
	GameStateMode_Gameplay;
	GameStateMode_Jump_Out;
	GameStateMode_Jump_In;
	GameStateMode_Death_Fall;
}

class GameState extends FlxState {

	public var _player:GamePlayer;
	public var _player_bullets:FlxGroup = new FlxGroup();
	public var _enemies:FlxGroup = new FlxGroup();
	public var _enemy_bullets:FlxGroup = new FlxGroup();
	public var _particles:FlxGroup = new FlxGroup();
	public var _pickups:FlxGroup = new FlxGroup();
	public var _healthbars:FlxGroup = new FlxGroup();
	
	public var _ui:GameUI;
	public var _mode:GameStateMode;
	
	public static var instance:GameState;
	
	override public function create():Void {
		super.create();
		instance = this;
		
		if (Stats._stage == 0) {
			FlxG.sound.playMusic(Assets.getMusic("assets/music/bottom1.mp3"));
		} else if (Stats._stage == 1) {
			FlxG.sound.playMusic(Assets.getMusic("assets/music/bottom2.mp3"));
		} else if (Stats._stage == 2) {
			FlxG.sound.playMusic(Assets.getMusic("assets/music/bottom3.mp3"));
		} else {
			FlxG.sound.playMusic(Assets.getMusic("assets/music/bottom4.mp3"));
		}
		
		var bg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_bg.png"));
		this.add(bg);
		
		_player = new GamePlayer();
		_player._x = FlxG.width * 0.5;
		_player._y = FlxG.height * 0;
		_player._vy = 15;
		this.add(_player);
		
		this.add(_player_bullets);
		this.add(_enemies);
		this.add(_healthbars);
		this.add(_enemy_bullets);
		this.add(_particles);
		this.add(_pickups);
		
		var fg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_fg.png"));
		this.add(fg);
		
		_ui = new GameUI();
		this.add(_ui);
		
		_mode = GameStateMode_Jump_In;
		_ui._fadeout.alpha = 1;
	}
	
	var _ct:Int = 0;
	override public function update():Void {
		super.update();
		_ct++;
		if (_mode == GameStateMode_Jump_In) {
			_player.game_update();
			_player._y += _player._vy;
			_player._vy *= 0.95;
			_ui._fadeout.alpha -= 0.05;
			_ui.game_update();
			if (_ui._fadeout.alpha <= 0) {
				_mode = GameStateMode_Gameplay;
			}
			
		} else if (_mode == GameStateMode_Jump_Out) {
			_player.game_update();
			_ui._fadeout.alpha += 0.05;
			_player._vy *= 1.1;
			_player._y += _player._vy;
			_player._vx = 0;
			if (_ui._fadeout.alpha >= 1) {
				FlxG.switchState(new TopState());
			}
			
		} else if (_mode == GameStateMode_Death_Fall) {
			_ui._fadeout.alpha += 0.05;
			_player._body.angle += 15;
			_player._y -= 5;
			for (i in _particles.members) if (i.alive) cast(i, BaseParticle).game_update();
			if (_ui._fadeout.alpha >= 1) {
				Stats._current_lives--;
				if (Stats._current_lives <= 0) {
					Stats.set_stage_params();
					FlxG.switchState(new TopState());
					
				} else {
					_player._x = FlxG.width * 0.5;
					_player._y = FlxG.height * 0;
					_player._vx = 0;
					_player._vy = 15;
					_player._dash_ct = 0;
					_player.rotate_to(-90);
					_player._body.angle = -90;
					
					_enemy_bullets.kill();
					_enemies.kill();
					_player_bullets.kill();
					_pickups.kill();
					_particles.kill();
					
					_enemy_bullets.revive();
					_enemies.revive();
					_player_bullets.revive();
					_pickups.revive();
					_particles.revive();
					
					_mode = GameStateMode_Jump_In;
				}
			}
			
		} else if (_mode == GameStateMode_Gameplay) {
			this.player_control();
			if (FlxG.keys.pressed.Z && Stats._current_energy > 5) {
				Stats._current_energy -= 5;
				var v = _player.get_bullet_facing(10);
				Bullet.cons_bullet(_player_bullets).init(_player.get_bullet_spawn().x, _player.get_bullet_spawn().y, v.x, v.y);
			}
			if (FlxG.keys.justPressed.X && Stats._current_energy > 30) {
				Stats._current_energy -= 30;
				_player._dash_ct = 15;
				
				var v = Util.normalized(Math.cos((_player._angle+90) * Util.DEG_TO_RAD), Math.sin((_player._angle+90) * Util.DEG_TO_RAD));
				v.scaleBy(10);
				_player._vx = v.x;
				_player._vy = v.y;
				_player._dash_vec.set(v.x, v.y);
			}
			if (_player._dash_ct > 0) _player._dash_ct--;
			
			Stats._current_energy = cast(Math.min(Stats._max_energy, Stats._current_energy+1),Int);
			
			if (_player._dash_ct > 0) {
				FlxG.overlap(_enemy_bullets, _player, function(b:Bullet, p:FlxSprite):Void {
					RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(b.x, b.y).p_set_alpha(1, 0).p_set_scale(0.5);
					b.kill();
				});
			} else {
				FlxG.overlap(_enemy_bullets, _player._hitbox, function(b:Bullet, p:FlxSprite):Void {
					if (_player._dash_ct <= 0) {
						_mode = GameStateMode_Death_Fall;
					}
					b.kill();
					RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(b.x, b.y).p_set_alpha(1, 0);
				});
			}
			
			FlxG.overlap(_player_bullets, _enemies, function(b:Bullet, p:BaseEnemy):Void {
				b.kill();
				p.hit();
				RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(b.x, b.y).p_set_alpha(1, 0).p_set_scale(0.5);
				if (p.is_dead()) {
					p.death_effect();
					p.kill();
				}
			});
			
			FlxG.overlap(_pickups, _player._hitbox, function(p:BasePickup, player:FlxSprite):Void {
				p.pickup_effect();
			});
			
			_player.game_update();
			_ui.game_update();
			for (i in _enemy_bullets.members) if (i.alive) cast(i, Bullet).game_update();
			for (i in _player_bullets.members) if (i.alive) cast(i, Bullet).game_update();
			for (i in _enemies.members) if (i.alive) cast(i, BaseEnemy).game_update();
			for (i in _particles.members) if (i.alive) cast(i, BaseParticle).game_update();
			for (i in _pickups.members) if (i.alive) cast(i, BasePickup).game_update();
			
			
			if (Stats._stage == 0) {
				stage_0_spawn();
			} else if (Stats._stage == 1) {
				stage_1_spawn();
			} else if (Stats._stage == 2) {
				stage_2_spawn();
			} else if (Stats._stage == 3) {
				stage_3_spawn();
			} else {
				stage_0_spawn();
			}
		}		
	}
	
	var _next_1up = Util.float_random(30, 45);
	public function do_1up(i:Float):Bool {
		if (Stats._current_lives <= 1) {
			_next_1up-=4;
		} else if (Stats._current_lives <= 3) {
			_next_1up-=2;
		} else {
			_next_1up-=1;
		}
		
		if (_next_1up < 0) {
			_next_1up = Util.float_random(35, 55);
			
			return true;
		}
		return false;
	}
	
	var _next_energyup = Util.float_random(15, 30);
	public function do_energyup(i:Float):Bool {
		_next_energyup-=1;
		if (_next_energyup < 0) {
			_next_energyup = Util.float_random(15, 30);
			
			return true;
		}
		return false;
	}
	
	
	var _spawn_ct = 0;
	private function stage_0_spawn():Void {
		_spawn_ct++;
		if (Stats._collected_fish < 10) {
			if ((_enemies.countLiving() < 2) || (_enemies.countLiving() < 8 && _spawn_ct % 50 == 0)) {
				spawn_jellyfish();
			}
			
		} else {
			if ((_enemies.countLiving() < 2) || (_enemies.countLiving() < 10 && _spawn_ct % 50 == 0)) {
				if (!Util.flxgroup_contains_instanceof(_enemies, BigJellyfishEnemy)) {
					spawn_bigjellyfish();
				}
				if (Util.float_random(0,7)<1) {
					spawn_bigjellyfish();
				} else {
					spawn_jellyfish();
				}
			}
		}
	}
	
	var _tuna_ct = 0;
	private function stage_1_spawn():Void {
		_spawn_ct++;
		if (Stats._collected_fish < 6) {
			if (!Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				spawn_tuna();
			}
		} else if (Stats._collected_fish < 35) {
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 150;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if ((_enemies.countLiving() < 4) || (_enemies.countLiving() < 12 && _spawn_ct % 50 == 0)) {
				spawn_jellyfish();
			}
		} else {
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 150;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if ((_enemies.countLiving() < 2) || (_enemies.countLiving() < 10 && _spawn_ct % 50 == 0)) {
				if (!Util.flxgroup_contains_instanceof(_enemies, BigJellyfishEnemy)) {
					spawn_bigjellyfish();
				}
				if (Util.float_random(0,7)<1) {
					spawn_bigjellyfish();
				} else {
					spawn_jellyfish();
				}
			}
		}
	}
	
	var _seal_ct = 0;
	private function stage_2_spawn():Void {
		_spawn_ct++;
		if (Stats._collected_fish < 10) {
			if (!Util.flxgroup_contains_instanceof(_enemies, SealEnemy)) {
				spawn_seal();
			}
		} else if (Stats._collected_fish < 40) {
			if ((_enemies.countLiving() < 6) || (_enemies.countLiving() < 9 && _spawn_ct % 20 == 0)) {
				spawn_jellyfish();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, SealEnemy)) {
				_seal_ct = 150;
			} else {
				_seal_ct--;
				if (_seal_ct <= 0) spawn_seal();
			}
			
		} else if (Stats._collected_fish < 80) {
			if ((_enemies.countLiving() < 6) || (_enemies.countLiving() < 10 && _spawn_ct % 20 == 0)) {
				spawn_jellyfish();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 250;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, SealEnemy)) {
				_seal_ct = 200;
			} else {
				_seal_ct--;
				if (_seal_ct <= 0) spawn_seal();
			}
		} else {
			if ((_enemies.countLiving() < 6) || (_enemies.countLiving() < 10 && _spawn_ct % 20 == 0)) {
				if (Util.float_random(0,7)<1) {
					spawn_bigjellyfish();
				} else {
					spawn_jellyfish();
				}
			}
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 250;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, SealEnemy)) {
				_seal_ct = 200;
			} else {
				_seal_ct--;
				if (_seal_ct <= 0) spawn_seal();
			}
		}
	}
	
	var _orca_ct = 0;
	private function stage_3_spawn():Void {
		if (Stats._collected_fish < 15) {
			if (!Util.flxgroup_contains_instanceof(_enemies, OrcaEnemy)) {
				spawn_orca();
			}
		} else if (Stats._collected_fish < 50) {
			if (Util.flxgroup_contains_instanceof(_enemies, OrcaEnemy)) {
				_orca_ct = 400;
			} else {
				_orca_ct--;
				if (_orca_ct <= 0) spawn_orca();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 250;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if ((_enemies.countLiving() < 6) || (_enemies.countLiving() < 8 && _spawn_ct % 40 == 0)) {
				spawn_jellyfish();
			}
			
		} else if (Stats._collected_fish < 100) {
			if (Util.flxgroup_contains_instanceof(_enemies, OrcaEnemy)) {
				_orca_ct = 500;
			} else {
				_orca_ct--;
				if (_orca_ct <= 0) spawn_orca();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, SealEnemy)) {
				_seal_ct = 325;
			} else {
				_seal_ct--;
				if (_seal_ct <= 0) spawn_seal();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 350;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if ((_enemies.countLiving() < 6) || (_enemies.countLiving() < 10 && _spawn_ct % 40 == 0)) {
				spawn_jellyfish();
			}
			
		} else {
			if (Util.flxgroup_contains_instanceof(_enemies, OrcaEnemy)) {
				_orca_ct = 500;
			} else {
				_orca_ct--;
				if (_orca_ct <= 0) spawn_orca();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, SealEnemy)) {
				_seal_ct = 400;
			} else {
				_seal_ct--;
				if (_seal_ct <= 0) spawn_seal();
			}
			if (Util.flxgroup_contains_instanceof(_enemies, TunaEnemy)) {
				_tuna_ct = 325;
			} else {
				_tuna_ct--;
				if (_tuna_ct <= 0) spawn_tuna();
			}
			if ((_enemies.countLiving() < 6) || (_enemies.countLiving() < 10 && _spawn_ct % 40 == 0)) {
				if (Util.float_random(0,8)<1) {
					spawn_bigjellyfish();
				} else {
					spawn_jellyfish();
				}
			}
		}
	}
	
	private function spawn_orca():Void {
		if (Util.float_random(0,2)<1) {
			OrcaEnemy.cons(_enemies).init(-150, Util.float_random(100, FlxG.height - 100), 1);
		} else {
			OrcaEnemy.cons(_enemies).init(FlxG.width+150, Util.float_random(100, FlxG.height - 100), -1);
		}
	}
	
	private function spawn_seal():Void {
		if (Util.float_random(0,2)<1) {
			SealEnemy.cons(_enemies).init(-150, Util.float_random(50, FlxG.height - 50), 1);
		} else {
			SealEnemy.cons(_enemies).init(FlxG.width+150, Util.float_random(50, FlxG.height - 50), -1);
		}
	}
	
	private function spawn_jellyfish():Void {
		if (Util.float_random(0,2)<1) {
			JellyfishEnemy.cons(_enemies).init(0, Util.float_random(50, FlxG.height - 50), 1);
		} else {
			JellyfishEnemy.cons(_enemies).init(FlxG.width, Util.float_random(50, FlxG.height - 50), -1);
		}
	}
	
	private function spawn_bigjellyfish():Void {
		if (Util.float_random(0,2)<1) {
			BigJellyfishEnemy.cons(_enemies).init(0, Util.float_random(50, FlxG.height - 50), 1);
		} else {
			BigJellyfishEnemy.cons(_enemies).init(FlxG.width, Util.float_random(50, FlxG.height - 50), -1);
		}
	}
	
	private function spawn_tuna():Void {
		var rnd = Util.float_random(0, 4);
		if (rnd < 1) {
			TunaEnemy.cons(_enemies).init(0, Util.float_random(50, 100), 1, 1);
		} else if (rnd < 2) {
			TunaEnemy.cons(_enemies).init(0, Util.float_random(400,450), 1, -1);
		} else if (rnd < 3) {
			TunaEnemy.cons(_enemies).init(FlxG.width, Util.float_random(50, 100), -1, 1);
		} else {
			TunaEnemy.cons(_enemies).init(FlxG.width, Util.float_random(400,450), -1, -1);
		}
	}
	
		
	var _control_vec:FlxVector = new FlxVector();
	private function player_control():Void {
		_control_vec.x = 0;
		_control_vec.y = 0;
		if (FlxG.keys.pressed.LEFT) {
			_control_vec.x = -1;
		}
		if (FlxG.keys.pressed.RIGHT) {
			_control_vec.x = 1;
		}
		if (FlxG.keys.pressed.UP) {
			_control_vec.y = -1;
		}
		if (FlxG.keys.pressed.DOWN) {
			_control_vec.y = 1;
		}
		if (_player._dash_ct > 0 && !_control_vec.isZero()) {
			_control_vec.normalize().scale(3);
			_player._vx = _player._dash_vec.x + _control_vec.x;
			_player._vy = _player._dash_vec.y + _control_vec.y;
			
		} else if (!_control_vec.isZero()) {
			if (FlxG.keys.pressed.SHIFT) {
				_control_vec.normalize().scale(2);
			} else {
				_control_vec.normalize().scale(5);
			}
			
			_player._vx = _control_vec.x;
			_player._vy = _control_vec.y;
		}
		
		var mv = Util.normalized(1, 0);
		
		if (_player._x < 150) {
			mv.x = (((150 - _player._x) / 150)) * 5;
		} else if (_player._x > 850) {
			mv.x = -(((_player._x - 850) / 150)) * 5;
		} else {
			mv.x = 0;
		}
		_player._vx += mv.x;
		_player._vy += mv.y;
		
		
		_player._x += _player._vx;
		_player._y += _player._vy;
		
		if (_player._y > 450) {
			_player._y = 450;
			_player._vy = 0;
		} else if (_player._y < 10) {
			if (_player._x > 440 && _player._x < 550) {
				_mode = GameStateMode_Jump_Out;
				return;
			}
			_player._y = 10;
			_player._vy = 0;
		}
		
		
		if (_player._x < 150 || _player._x > 850) {
			_player._vx *= 0.5;
			_player._vy *= 0.5;
		} else {
			_player._vx *= 0.95;
			_player._vy *= 0.95;
		}
	}
	
}