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
import particle.*;
import particle.RotateFadeVelParticle;
import pickup.GoldFishPickup;

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
	
	public function init(x:Float, y:Float, xdir:Float):Void {
		this.reset(x, y);
	}
	
	public override function game_update():Void {
		this.x += 2;
		
		if (Util.float_random(0,100) < 1 && Util.flxpt(this.x, this.y).distanceTo(Util.flxpt2(GameState.instance._player.get_bullet_spawn().x,GameState.instance._player.get_bullet_spawn().y)) > 100) {
			var dv = Util.normalized(
				GameState.instance._player.get_bullet_spawn().x - this.x + Util.float_random( -40, 40), 
				GameState.instance._player.get_bullet_spawn().y - this.y + Util.float_random( -40, 40)
			);
			dv.scaleBy(2.5);
			Bullet.cons_bullet(GameState.instance._enemy_bullets, true).init(this.x, this.y,dv.x,dv.y);
		}
		
		if (this.x < 0 || this.y < 0 || this.x > FlxG.width || this.y > FlxG.height) {
			this.kill();
		}
		
	}
	
	public override function death_effect():Void {
		RotateFadeVelParticle.cons_particle(GameState.instance._particles).init(this.x, this.y).p_set_alpha(1, 0);
		GoldFishPickup.cons(GameState.instance._pickups).init(this.x, this.y);
	}
	
}