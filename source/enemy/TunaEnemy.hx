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
import flixel.util.FlxPoint;
import openfl.Assets;
import particle.*;
import particle.RotateFadeVelParticle;
import pickup.GoldFishPickup;
import pickup.*;

class TunaEnemy extends BaseEnemy {
	
	public static function cons(g:FlxGroup):TunaEnemy {		
		var rtv:TunaEnemy = cast(g.getFirstAvailable(TunaEnemy),TunaEnemy);		
		if (rtv == null) {
			rtv = new TunaEnemy();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/tuna.png"));
	}
	
	var _xdir:Float;
	var _ydir:Float;
	public function init(x:Float, y:Float, xdir:Float, ydir:Float):Void {
		this.reset(x, y);
		_xdir = xdir;
		_ydir = ydir;
		this.health = 4;
		this.flipX = _xdir > 0;
		
	}
	
	var _ct:Int = 0;
	public override function game_update():Void {
		super.game_update();
		this.x += _xdir * 4;
		_ct++;
		if (_ct % 10 == 0) {
			Util.sfx("shoot3.mp3", 0.3);
			Bullet.cons_bullet(GameState.instance._enemy_bullets, true).init(this.x + 72/2, this.y + 38/2, 0, 3 * _ydir);
		}
		
		if (this.x < -100 || this.y < -100 || this.x > FlxG.width + 100 || this.y > FlxG.height + 100) {
			this.kill();
		}
	}
	
	public override function death_effect():Void {
		RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(this.x, this.y).p_set_alpha(1, 0).p_set_scale(1.5);
		if (GameState.instance.do_1up(3)) {
			OneUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random( -40, 40), this.y + Util.float_random( -40, 40));
		} else if (GameState.instance.do_energyup(3)) {
			EnergyUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-40,40), this.y + Util.float_random(-40,40));
		} else {
			for (i in 0 ... 3) GoldFishPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-10,10) , this.y + Util.float_random(-10,10) );
		}
	}
	
}