package ;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;

class GamePlayer extends FlxSprite {
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/player.png"));
	}
	
	var _tar_ang:Float = 0;
	public function rotate_to(tar_ang:Float):Void {
		_tar_ang = tar_ang + 90;
	}
	
	public override function update():Void {
		super.update();
		
		var facing_x = 0;
		var facing_y = 0;
		if (FlxG.keys.pressed.LEFT) {
			facing_x = 1;
		}
		if (FlxG.keys.pressed.RIGHT) {
			facing_x = -1;
		}
		if (FlxG.keys.pressed.UP) {
			facing_y = 1;
		}
		if (FlxG.keys.pressed.DOWN) {
			facing_y = -1;
		}
		
		if (facing_x != 0 || facing_y != 0) {
			this.rotate_to(Math.atan2(facing_y, facing_x) * Util.RAD_TO_DEG);
		}
		this.angle += Util.lerp_deg(this.angle, _tar_ang, 0.2);
	}
	
	var _bullet_facing = new Vector3D(0, 0, 0);
	public function get_bullet_facing(sc:Float):Vector3D {
		_bullet_facing.x = Math.cos((this.angle+90) * Util.DEG_TO_RAD);
		_bullet_facing.y = Math.sin((this.angle+90) * Util.DEG_TO_RAD);
		_bullet_facing.scaleBy(sc);
		return _bullet_facing;
	}
	
}