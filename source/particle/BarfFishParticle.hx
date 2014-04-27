package particle;
import flash.geom.Vector3D;
import flixel.util.FlxPoint;
import flash.geom.Point;
import flixel.util.FlxVector;
import particle.BaseParticle;
import flixel.group.FlxGroup;
import openfl.Assets;

class BarfFishParticle extends BaseParticle{

	public static function cons_particle(g:FlxGroup):BarfFishParticle {
		var rtv:BarfFishParticle = cast(g.getFirstAvailable(BarfFishParticle), BarfFishParticle);
		if (rtv == null) {
			rtv = new BarfFishParticle();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/goldfish.png")); 
	}
	
	var _ct:Float;
	var _curve:BezierCurve;
	
	public function init(start:FlxPoint, end:FlxPoint):BarfFishParticle {
		this.reset(start.x, start.y);
		_ct = 0;
		var rnd = Util.float_random(80, 150);
		_curve = BezierCurve.curve_pool_get().cons(
			BezierCurve.point_pool_get(start.x, start.y),
			BezierCurve.point_pool_get(start.x - 30, start.y-rnd),
			BezierCurve.point_pool_get(end.x + 30,end.y-rnd),
			BezierCurve.point_pool_get(end.x,end.y)
		);
		return this;
	}
	
	public override function game_update():Void {
		_ct += 0.03;
		var pt = _curve.get_pt_for_t(_ct);
		this.x = pt.x;
		this.y = pt.y;
		BezierCurve.point_pool_dispose(pt);
		pt = null;
		
		if (_ct >= 1) {
			BezierCurve.curve_pool_dispose(_curve);
			_curve = null;
			this.kill();
			
			TopState.instance.fish_feed_anim_complete();
		}
	}
	
}