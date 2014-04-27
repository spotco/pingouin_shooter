package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;

import flash.filters.GlowFilter;
import flash.filters.BitmapFilter;
import flixel.effects.FlxSpriteFilter;

class Bullet extends FlxSprite {
	
	public static function cons_bullet(g:FlxGroup, enemy:Bool = false):Bullet {
		var rtv:Bullet = cast(g.getFirstAvailable(Bullet), Bullet);
		if (rtv == null) {
			rtv = new Bullet(enemy);
			g.add(rtv);
		}
		return rtv;
	}
	
	var _enemy:Bool;
	static var ct = 0;
	public function new(enemy:Bool) {
		super();
		_enemy = enemy;
		if (_enemy) {
			this.loadGraphic(Assets.getBitmapData("assets/images/fx/enemy_bullet.png"));
		} else {
			this.loadGraphic(Assets.getBitmapData("assets/images/fx/player_bullet.png")); 
		}
		
	}
	
	public function init(x:Float, y:Float, vx:Float, vy:Float):Bullet {
		this.reset(x, y);
		this.velocity.x = vx;
		this.velocity.y = vy;
		
		if (_enemy) {
			this.angle = 0;
		} else {
			this.angle = Math.atan2(vy, vx) * Util.RAD_TO_DEG - 90;
		}
		return this;
	}
	
	public function game_update():Void {
		this.x += this.velocity.x;
		this.y += this.velocity.y;
		
		if (this.x < 0 || this.y < 0 || this.x > FlxG.width || this.y > FlxG.height) {
			this.kill();
		}
	}
	
}