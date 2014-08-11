package ;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.FlxObject;
import openfl.Assets;
import flixel.util.*;

class GamePlayer extends FlxGroup {

	public var _body:FlxSprite = new FlxSprite();
	public var _hitbox:FlxSprite = new FlxSprite();
	
	public var _dash_ct:Float = 0;
	public var _dash_vec:FlxVector = new FlxVector();
	
	public var _x = 0.0;
	public var _y = 0.0;
	public var _vx = 0.0;
	public var _vy = 0.0;
	public var _angle = 0.0;
	
	public function new() {
		super();
		
		_body.loadGraphic(Assets.getBitmapData("assets/images/char/player.png"), true, 50, 78);
		
		_body.animation.add("stand", [0,1,2,3,2,1], 2, true);
		_body.animation.add("swim", [4,5,6,7,6,5], 10, true);
		_body.animation.add("dash", [8,9], 15, true);
		_body.animation.play("stand", true);
		
		_hitbox.loadGraphic(Assets.getBitmapData("assets/images/player_hitbox.png"));
		
		this.add(_body);
		this.add(_hitbox);
		_hitbox.alpha = 0;
		
	}
	
	var _tar_ang:Float = 0;
	public function rotate_to(tar_ang:Float):Void {
		_tar_ang = tar_ang + 90;
	}
	
	var _hitbox_flash_ct = 0;
	public function game_update():Void {
		super.update();
		
		var facing_x = 0.0;
		var facing_y = 0.0;
		if (Stats._control_mode == ControlMode_ARROWZX) {
			if (Util.move_left()) {
				facing_x = 1;
			}
			if (Util.move_right()) {
				facing_x = -1;
			}
			if (Util.move_up()) {
				facing_y = 1;
			}
			if (Util.move_down()) {
				facing_y = -1;
			}
		} else if (FlxG.mouse.x != this.get_bullet_spawn().x) {
			var spawn = this.get_bullet_spawn();
			var v = Util.normalized(FlxG.mouse.x - spawn.x, FlxG.mouse.y - spawn.y);
			facing_x = -v.x;
			facing_y = -v.y;
		}
		
		if (facing_x != 0 || facing_y != 0 && GameState.instance._mode == GameStateMode_Gameplay) {
			this.rotate_to(Math.atan2(facing_y, facing_x) * Util.RAD_TO_DEG);
		}
		
		_angle += Util.lerp_deg(_angle, _tar_ang, 0.2);
		_body.angle = _angle;
		_body.x = _x;
		_body.y = _y;
		_hitbox.x = this.get_bullet_spawn().x;
		_hitbox.y = this.get_bullet_spawn().y;
		
		_hitbox.alpha *= 0.9;
		_hitbox_flash_ct++;
		if (_hitbox_flash_ct % 30 == 0) _hitbox.alpha = 1;
		
		if (_dash_ct > 0) {
			_body.animation.play("dash");
		} else if (Util.flxpt(_vx,_vy).distanceTo(Util.FLXPT_ZERO) < 3) {
			_body.animation.play("stand");
		} else {
			_body.animation.play("swim");
		}
	}
	
	var _bullet_facing = new Vector3D();
	public function get_bullet_facing(sc:Float):Vector3D {
		_bullet_facing.x = Math.cos((_angle+90) * Util.DEG_TO_RAD);
		_bullet_facing.y = Math.sin((_angle+90) * Util.DEG_TO_RAD);
		_bullet_facing.scaleBy(sc);
		return _bullet_facing;
	}
	
	var _bullet_spawn = new Vector3D();
	public function get_bullet_spawn():Vector3D {
		_bullet_spawn.x = _x + 11;
		_bullet_spawn.y = _y + 20;
		_bullet_spawn.z = 0;
		return _bullet_spawn;
	}
	
}