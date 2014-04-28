package particle;
import particle.BaseParticle;
import flixel.group.FlxGroup;
import openfl.Assets;

class RotateFadeVelParticle extends BaseParticle {
		
	public static function cons_particle(g:FlxGroup):RotateFadeVelParticle {
		var rtv:RotateFadeVelParticle = cast(g.getFirstAvailable(RotateFadeVelParticle), RotateFadeVelParticle);
		if (rtv == null) {
			rtv = new RotateFadeVelParticle();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/fx/enemy_explosion.png")); 
	}
	
	var _vx:Float = 0;
	var _vy:Float = 0;
	var _vr:Float = 0;
	var _ct:Float = 0;
	
	var _has_played_sfx:Bool = false;
	public function init(x:Float, y:Float):RotateFadeVelParticle {
		this.reset(x, y);
		_ct = 0;
		this.alpha = 1;
		this.scale.x = 1;
		this.scale.y = 1;
		_has_played_sfx = false;
		
		return this;
	}
	
	public function p_set_velocity(vx:Float, vy:Float):RotateFadeVelParticle {
		_vx = vx;
		_vy = vy;	
		return this;
	}
	
	public function p_set_vr(vr:Float):RotateFadeVelParticle {
		_vr = vr;
		return this;
	}
	
	public function p_set_scale(s:Float):RotateFadeVelParticle {
		this.scale.x = s;
		this.scale.y = s;
		return this;
	}
	
	public function p_final_scale(s:Float):RotateFadeVelParticle {
		return this;
	}
	
	var _initial_alpha:Float = 1;
	var _final_alpha:Float = 1;
	public function p_set_alpha(initial:Float, final:Float):RotateFadeVelParticle {
		_initial_alpha = initial;
		_final_alpha = final;
		return this;
	}
	
	public override function game_update():Void {
		
		if (!_has_played_sfx ) {
			_has_played_sfx = true;
			Util.sfx("sfx_explosion.mp3", Math.min(this.scale.x/3,1));
		}
		
		this.angle += _vr;
		this.x += _vx;
		this.y += _vy;
		
		this.alpha = _initial_alpha + (_final_alpha - _initial_alpha) * (_ct);
		
		_ct += 0.1;
		if (_ct >= 1) {
			this.kill();
		}
	}
}