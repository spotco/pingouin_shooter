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

class GameState extends FlxState {

	var _player:GamePlayer;
	var _player_bullets:FlxGroup = new FlxGroup();
	var _enemies:FlxGroup = new FlxGroup();
	
	override public function create():Void {
		super.create();
		
		var bg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_bg.png"));
		this.add(bg);
		
		_player = new GamePlayer();
		_player.x = FlxG.width * 0.5;
		_player.y = FlxG.height * 0.5;
		this.add(_player);
		
		this.add(_player_bullets);
		this.add(_enemies);
		
		var fg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/bottom/bottom_fg.png"));
		this.add(fg);
	}
	
	
	override public function update():Void {
		super.update();
		this.player_control();
		
		if (FlxG.keys.pressed.Z) {
			var v = _player.get_bullet_facing(10);
			PlayerBullet.cons_bullet(_player_bullets).init(_player.x + 13, _player.y + 22, v.x, v.y);
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
			_player.velocity.x = _control_vec.x;
			_player.velocity.y = _control_vec.y;
		}
		_player.x += _player.velocity.x;
		_player.y += _player.velocity.y;
		_player.velocity.x *= 0.95;
		_player.velocity.y *= 0.95;
	}
	
}