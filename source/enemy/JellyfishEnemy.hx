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
import pickup.*;

class JellyfishEnemy extends BaseEnemy {
	
	public static function cons(g:FlxGroup):JellyfishEnemy {		
		var rtv:JellyfishEnemy = cast(g.getFirstAvailable(JellyfishEnemy),JellyfishEnemy);		
		if (rtv == null) {
			rtv = new JellyfishEnemy();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/jellyfish.png"));
	}
	
	var _xdir:Float = 1;
	var _tar:FlxPoint = new FlxPoint();
	var _delay:Float = 0;
	
	public function init(x:Float, y:Float, xdir:Float):Void {
		this.reset(x, y);
		this.health = 2;
		_tar.set(x+xdir*80, y);
		_xdir = xdir;
		_delay = 0;
		this.flipX = _xdir > 0;
	}
	
	public override function game_update():Void {
		super.game_update();
		
		if (_delay > 0) {
			_delay--;
			if (_delay <= 0) {
				var v = Util.normalized(Util.float_random(60, 120) * _xdir, Util.float_random( -100, 100));
				v.scaleBy(120);
				_tar.set(x + v.x, y + v.y);
				
				if (Util.pt_dist(x,y,GameState.instance._player._x,GameState.instance._player._y) > 40) {
					var dv = Util.normalized(
						GameState.instance._player.get_bullet_spawn().x - this.x + Util.float_random( -40, 40), 
						GameState.instance._player.get_bullet_spawn().y - this.y + Util.float_random( -40, 40)
					);
					dv.scaleBy(2.5);
					Bullet.cons_bullet(GameState.instance._enemy_bullets, true).init(this.x, this.y, dv.x, dv.y);
				}
			}
			
		} else if (Util.pt_dist(x, y, _tar.x, _tar.y) < 1) {
			_delay = Util.float_random(10, 40);
			
		} else {
			var p = Util.drp_pos(Util.flxpt(x,y), _tar, 30);
			this.x = p.x;
			this.y = p.y;
			
		}
		
		if (this.x < 0 || this.y < 0 || this.x > FlxG.width || this.y > FlxG.height) {
			this.kill();
		}
	}
	
	public override function death_effect():Void {
		RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(this.x, this.y).p_set_alpha(1, 0);
		if (GameState.instance.do_1up(1)) {
			OneUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random( -40, 40), this.y + Util.float_random( -40, 40));
		} else if (GameState.instance.do_energyup(1)) {
			EnergyUpPickup.cons(GameState.instance._pickups).init(this.x + Util.float_random(-40,40), this.y + Util.float_random(-40,40));
		} else {
			GoldFishPickup.cons(GameState.instance._pickups).init(this.x, this.y);
		}
	}
	
}