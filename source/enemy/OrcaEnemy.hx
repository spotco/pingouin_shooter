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

class OrcaEnemy extends BaseEnemy {
	
	public static function cons(g:FlxGroup):OrcaEnemy {		
		var rtv:OrcaEnemy = cast(g.getFirstAvailable(OrcaEnemy),OrcaEnemy);		
		if (rtv == null) {
			rtv = new OrcaEnemy();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/orca.png"));
		this.centerOrigin();
	}
	
	var _xdir:Float;
	var _vel:Vector3D = new Vector3D();
	public function init(x:Float, y:Float, xdir:Float):Void {
		this.reset(x, y);
		_xdir = xdir;
		this.health = 20;
		this.flipX = xdir > 0;
		this.scale.x = 0.7;
		this.scale.y = 0.8;
		this.updateHitbox();
		_theta = 0;
		this.centerOrigin();
	}
	
	var _ct:Int = 0;
	var _theta:Float;
	
	public override function game_update():Void {
		super.game_update();
		_ct++;
		this.x += _xdir * 2;
		if (_ct%3==0){
			_theta += 0.1;
			var v = Util.normalized(Math.cos(_theta), Math.sin(_theta));
			v.scaleBy(3);
			Bullet.cons_bullet(GameState.instance._enemy_bullets, true).init(this.x + 70, this.y + 40, v.x, v.y);
		}
		if (this.x < -200 || this.y < -200 || this.x > FlxG.width + 200 || this.y > FlxG.height + 200) {
			this.kill();
		}
	}
	
	public override function death_effect():Void {
		RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(this.x, this.y).p_set_alpha(1, 0).p_set_scale(3);
		if (GameState.instance.do_1up(8)) {
			OneUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random( -40, 40), this.y + Util.float_random( -40, 40));
		} else if (GameState.instance.do_energyup(8)) {
			EnergyUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-40,40), this.y + Util.float_random(-40,40));
		} else {
			for (i in 0 ... 8) GoldFishPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-10,10) , this.y + Util.float_random(-10,10) );
		}
	}
	
}