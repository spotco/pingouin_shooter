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
}

class GameState extends FlxState {

	public var _player:GamePlayer;
	public var _player_bullets:FlxGroup = new FlxGroup();
	public var _enemies:FlxGroup = new FlxGroup();
	public var _enemy_bullets:FlxGroup = new FlxGroup();
	public var _particles:FlxGroup = new FlxGroup();
	public var _pickups:FlxGroup = new FlxGroup();
	
	public var _ui:GameUI;
	public var _mode:GameStateMode;
	
	public static var instance:GameState;
	
	override public function create():Void {
		super.create();
		instance = this;
		
		var bg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_bg.png"));
		this.add(bg);
		
		_player = new GamePlayer();
		_player._x = FlxG.width * 0.5;
		_player._y = FlxG.height * 0;
		_player._vy = 15;
		this.add(_player);
		
		this.add(_player_bullets);
		this.add(_enemies);
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
	
	
	override public function update():Void {
		super.update();
		if (_mode == GameStateMode_Jump_In) {
			_player.game_update();
			_player._y += _player._vy;
			_player._vy *= 0.95;
			_ui._fadeout.alpha -= 0.05;
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
			
		} else if (_mode == GameStateMode_Gameplay) {
			this.player_control();
			if (FlxG.keys.pressed.Z) {
				var v = _player.get_bullet_facing(10);
				Bullet.cons_bullet(_player_bullets).init(_player.get_bullet_spawn().x, _player.get_bullet_spawn().y, v.x, v.y);
			}
			
			FlxG.overlap(_enemy_bullets, _player._hitbox, function(b:Bullet, p:FlxSprite):Void {
				b.kill();
			});
			
			FlxG.overlap(_player_bullets, _enemies, function(b:Bullet, p:BaseEnemy):Void {
				b.kill();
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
			
			if (Util.float_random(0, 50) < 2) {
				JellyfishEnemy.cons(_enemies).init(0,Util.float_random(50, FlxG.height-50),0);
			}	
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
		if (!_control_vec.isZero()) {
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