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

class SealEnemy extends BaseEnemy {
	
	public static function cons(g:FlxGroup):SealEnemy {		
		var rtv:SealEnemy = cast(g.getFirstAvailable(SealEnemy),SealEnemy);		
		if (rtv == null) {
			rtv = new SealEnemy();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/seal.png"));
		this.centerOrigin();
	}
	
	var _xdir:Float;
	var _initial_follow:Bool = true;
	var _vel:Vector3D = new Vector3D();
	public function init(x:Float, y:Float, xdir:Float):Void {
		this.reset(x, y);
		_xdir = xdir;
		this.health = 6;
		this.flipX = true;
		this.flipY = xdir < 0;
		_initial_follow = true;
		this._vel.x = xdir;
		this._vel.y = Util.float_random( -2, 2);
		this._vel.normalize();
		this._vel.scaleBy(4);
		this.scale.x = 0.8;
		this.scale.y = 0.8;
	}
	
	var _ct:Int = 0;
	var _tar_vel:Vector3D = new Vector3D();
	var _tar_ang:Float = 0;
	
	public override function game_update():Void {
		super.game_update();
		_ct++;
		
		this.angle = Math.atan2(_vel.y, _vel.x) * Util.RAD_TO_DEG;
		
		if (_initial_follow) {
			var v = Util.normalized(GameState.instance._player._x - this.x, GameState.instance._player._y-this.y);
			v.scaleBy(0.15);
			_vel.x += v.x;
			_vel.y += v.y;
			_vel.normalize();
			_vel.scaleBy(4);
			
			this.x += _vel.x;
			this.y += _vel.y;
			
			if (Util.pt_dist(x,y,GameState.instance._player._x,GameState.instance._player._y) > 150 && _ct % 4 == 0) {
				var dv = Util.normalized(
					GameState.instance._player.get_bullet_spawn().x - this.x + Util.float_random( -40, 40), 
					GameState.instance._player.get_bullet_spawn().y - this.y + Util.float_random( -40, 40)
				);
				dv.scaleBy(2.5);
				Bullet.cons_bullet(GameState.instance._enemy_bullets, true).init(this.x + 25, this.y + 12.5, dv.x, dv.y);
			}
			
			if (Util.pt_dist(this.x, this.y, GameState.instance._player._x, GameState.instance._player._y) < 170) {
				_initial_follow = false;
				v.normalize();
				v.negate();
				var normal = v.crossProduct(Util.Z_VEC);
				normal.normalize();
				normal.scaleBy(Util.float_random( -1.4, 1.4));
				v = Util.normalized(v.x + normal.x, v.y + normal.y);
				v.scaleBy(5);
				
				_tar_vel.x = v.x;
				_tar_vel.y = v.y;
				
				var i = 0.0;
				while (i < 3.14 * 2) {
					var dv = Util.normalized(Math.cos(i), Math.sin(i));
					dv.scaleBy(2);
					Bullet.cons_bullet(GameState.instance._enemy_bullets, true).init(this.x + 25, this.y + 12.5, dv.x, dv.y);
					i += 0.4;
				}
				
			}
			
		} else {
			_vel.x = Util.drp(_vel.x, _tar_vel.x, 30);
			_vel.y = Util.drp(_vel.y, _tar_vel.y, 30);
			_vel.normalize();
			_vel.scaleBy(5);
		
			this.x += _vel.x;
			this.y += _vel.y;
		}
		
		
		if (this.x < -200 || this.y < -200 || this.x > FlxG.width + 200 || this.y > FlxG.height + 200) {
			this.kill();
		}
	}
	
	public override function death_effect():Void {
		RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(this.x, this.y).p_set_alpha(1, 0).p_set_scale(3);
		if (GameState.instance.do_1up(5)) {
			OneUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random( -40, 40), this.y + Util.float_random( -40, 40));
		} else if (GameState.instance.do_energyup(5)) {
			EnergyUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-40,40), this.y + Util.float_random(-40,40));
		} else {
			for (i in 0 ... 5) GoldFishPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-10,10) , this.y + Util.float_random(-10,10) );
		}
	}
	
}