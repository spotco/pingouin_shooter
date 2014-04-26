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

class GameState extends FlxState {

	public var _player:GamePlayer;
	public var _player_bullets:FlxGroup = new FlxGroup();
	public var _enemies:FlxGroup = new FlxGroup();
	public var _enemy_bullets:FlxGroup = new FlxGroup();
	
	override public function create():Void {
		super.create();
		
		var bg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_bg.png"));
		this.add(bg);
		
		_player = new GamePlayer();
		_player._x = FlxG.width * 0.5;
		_player._y = FlxG.height * 0.5;
		this.add(_player);
		
		this.add(_player_bullets);
		this.add(_enemies);
		this.add(_enemy_bullets);
		
		var fg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_fg.png"));
		this.add(fg);
	}
	
	
	override public function update():Void {
		super.update();
		this.player_control();
		
		if (FlxG.keys.pressed.Z) {
			var v = _player.get_bullet_facing(10);
			Bullet.cons_bullet(_player_bullets).init(_player.get_bullet_spawn().x, _player.get_bullet_spawn().y, v.x, v.y);
		}
		
		FlxG.overlap(_enemy_bullets, _player._hitbox, function(b:Bullet, p:FlxSprite):Void {
			b.kill();
		});
		
		FlxG.overlap(_player_bullets, _enemies, function(b:Bullet, p:FlxSprite):Void {
			b.kill();
			p.kill();
		});
		
		if (Util.float_random(0, 50) < 2) {
			JellyfishEnemy.cons(_enemies, this, 0, Util.float_random(0, FlxG.height), 0);
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
			_control_vec.normalize().scale(5);
			_player._vx = _control_vec.x;
			_player._vy = _control_vec.y;
		}
		_player._x += _player._vx;
		_player._y += _player._vy;
		_player._vx *= 0.95;
		_player._vy *= 0.95;
	}
	
}