package ;
import flash.display.Graphics;
import flash.geom.Point;

/*
 			BezierCurve.curve_pool_dispose(BezierCurve.curve_pool_get().cons(
				_point_list[i].as_point(), 
				_point_list[i + 1].as_point(), 
				_point_list[i + 2].as_point(), 
				_point_list[i + 3].as_point()
			).draw(_curve_draw.graphics).draw_center(_curve_draw.graphics));
 */

class BezierCurve {
	public var _p0:Point;
	public var _p1:Point;
	public var _p2:Point;
	public var _p3:Point;
	public static var TOLERANCE:Float = 100;
	
	public function new(){}
	public static var _curve_pool = new Array<BezierCurve>();
	public static function curve_pool_get():BezierCurve {
		return (_curve_pool.length > 0) ? _curve_pool.pop() : new BezierCurve();
	}
	
	public static function curve_pool_dispose(b:BezierCurve):Void {
		_curve_pool.push(b);
		point_pool_dispose(b._p0);
		point_pool_dispose(b._p1);
		point_pool_dispose(b._p2);
		point_pool_dispose(b._p3);
	}
	
	public static var _point_pool = new Array<Point>();
	public static function point_pool_get(x:Float, y:Float):Point {
		var rtv = (_point_pool.length > 0) ? _point_pool.pop() : new Point();
		rtv.x = x; rtv.y = y;
		return rtv;
	}
	
	public static function point_pool_dispose(p:Point):Void {
		_point_pool.push(p);
	}
	
	public function cons(p0:Point, p1:Point, p2:Point, p3:Point):BezierCurve {
		_p0 = p0;
		_p1 = p1;
		_p2 = p2;
		_p3 = p3;
		return this;
	}
	
	public static function midpoint(pt_a:Point, pt_b:Point):Point {
		return point_pool_get((pt_b.x - pt_a.x) / 2 + pt_a.x, (pt_b.y - pt_a.y) / 2 + pt_a.y);
	}
	
	public function draw(g:Graphics):BezierCurve {
		if (this.is_sufficiently_flat()) {
			g.moveTo(_p0.x, _p0.y);
			g.lineTo(_p3.x, _p3.y);
		} else {
			var l0 = point_pool_get(_p0.x,_p0.y);
			var l1 = midpoint(_p0, _p1);
			var m = midpoint(_p1, _p2);
			var l2 = midpoint(l1, m);
			
			var r3 = point_pool_get(_p3.x,_p3.y);
			var r2 = midpoint(_p2, _p3);
			var r1 = midpoint(m, r2);
			var r0 = midpoint(l2, r1);
			
			var l3 = point_pool_get(r0.x,r0.y);
			
			BezierCurve.point_pool_dispose(m);
			BezierCurve.curve_pool_dispose(curve_pool_get().cons(l0, l1, l2, l3).draw(g));
			BezierCurve.curve_pool_dispose(curve_pool_get().cons(r0, r1, r2, r3).draw(g));
		}
		return this;
	}
	
	public function get_pt_for_t(t:Float):Point {
		var cp0 = (1 - t)*(1 - t)*(1 - t);
		var cp1 = 3 * t * (1-t)*(1-t);
		var cp2 = 3 * t * t * (1 - t);
		var cp3 = t * t * t;
		return BezierCurve.point_pool_get(
			cp0 * _p0.x + cp1 * _p1.x + cp2 * _p2.x + cp3 * _p3.x,
			cp0 * _p0.y + cp1 * _p1.y + cp2 * _p2.y + cp3 * _p3.y
		);
	}
	
	public function is_sufficiently_flat():Bool {
		if (Util.pt_dist(_p0.x, _p0.y, _p3.x, _p3.y) < 5) return true;
		var ux = 3.0 * _p1.x - 2.0 * _p0.x - _p3.x; 
		ux *= ux; 
		var uy = 3.0 * _p1.y - 2.0 * _p0.y - _p3.y; 
		uy *= uy; 
		var vx = 3.0 * _p2.x - 2.0 * _p3.x - _p0.x; 
		vx *= vx; 
		var vy = 3.0 * _p2.y - 2.0 * _p3.y - _p0.y; 
		vy *= vy; 
		if (ux < vx) ux = vx;
		if (uy < vy) uy = vy;
		return (ux+uy <= TOLERANCE);
	}
	
}