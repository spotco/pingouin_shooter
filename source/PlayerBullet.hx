package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;

class PlayerBullet extends FlxSprite {
	
	public static function cons_bullet(g:FlxGroup):PlayerBullet {
		var rtv:PlayerBullet = cast(g.getFirstAvailable(PlayerBullet), PlayerBullet);
		if (rtv == null) {
			rtv = new PlayerBullet();
			g.add(rtv);
		}
		return rtv;
	}
	static var ct = 0;
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/fx/player_bullet.png")); 
	}
	
	public function init(x:Float, y:Float, vx:Float, vy:Float):PlayerBullet {
		this.reset(x, y);
		this.velocity.x = vx;
		this.velocity.y = vy;
		
		this.angle = Math.atan2(vy, vx) * Util.RAD_TO_DEG - 90;
		
		return this;
	}
	
	public override function update():Void {
		this.x += this.velocity.x;
		this.y += this.velocity.y;
		
		if (this.x < 0 || this.y < 0 || this.x > FlxG.width || this.y > FlxG.height) {
			this.kill();
		}
	}
	
}