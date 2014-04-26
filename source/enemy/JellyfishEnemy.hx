package enemy;
import flixel.group.FlxGroup;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.FlxObject;
import openfl.Assets;

class JellyfishEnemy extends BaseEnemy {
	
	var _game:GameState;
	
	public static function cons(g:FlxGroup, state:GameState, x:Float, y:Float, xdir:Float):JellyfishEnemy {		
		var rtv:JellyfishEnemy = cast(g.getFirstAvailable(JellyfishEnemy),JellyfishEnemy);		
		if (rtv == null) {
			rtv = new JellyfishEnemy();
			g.add(rtv);
		}
		rtv.init(state, x,y, xdir);
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/jellyfish.png"));
	}
	
	private function init(state:GameState, x:Float, y:Float, xdir:Float):Void {
		this.reset(x, y);
		_game = state;
	}
	
	public override function update():Void {
		this.x += 2;
		
		if (Util.float_random(0,100) < 1) {
			var dv = Util.normalized(
				_game._player.get_bullet_spawn().x - this.x + Util.float_random( -5, 5), 
				_game._player.get_bullet_spawn().y - this.y + Util.float_random( -5, 5)
			);
			dv.scaleBy(4);
			Bullet.cons_bullet(_game._enemy_bullets, true).init(this.x, this.y,dv.x,dv.y);
		}
		
		if (this.x < 0 || this.y < 0 || this.x > FlxG.width || this.y > FlxG.height) {
			this.kill();
		}
		
	}
	
}