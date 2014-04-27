package ;

import flash.geom.Vector3D;
import flixel.*;
import enemy.*;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.FlxBasic;

class Util {
	
	public static var DEG_TO_RAD = Math.PI / 180;
	public static var RAD_TO_DEG = 180 / Math.PI;
	
	public static var FLXPT_ZERO = new FlxPoint(0, 0);
	
	public static function flxgroup_contains_instanceof(f:FlxGroup, c:Class<FlxBasic>):Bool {
		for (i in f.members) {
			if (i.alive && i.exists && Type.getClassName(c) == Type.getClassName(Type.getClass(i))) {
				return true;
			}
		}
		return false;
	}
	
	public static function flxgroup_count_of(f:FlxGroup, c:Class<FlxBasic>):Int {
		var rtv = 0;
		for (i in f.members) {
			if (i.alive && i.exists && Type.getClassName(c) == Type.getClassName(Type.getClass(i))) rtv++;
		}
		return rtv;
	}
	
	public static function lerp_deg(src:Float, dest:Float, amt:Float) {
		var shortest_angle=((((dest - src) % 360) + 540) % 360) - 180;
		return shortest_angle * amt;
	}
	
	static var _lerp:FlxPoint = new FlxPoint(0, 0);
	public static function lerp_pos(a:FlxPoint, b:FlxPoint, t:Float):FlxPoint {
		_lerp.x = lerp(a.x, b.x, t);
		_lerp.y = lerp(a.y, b.y, t);
		return _lerp;
	}
	
	public static function drp_pos(a:FlxPoint, b:FlxPoint, div:Float):FlxPoint {
		_lerp.x = drp(a.x, b.x, div);
		_lerp.y = drp(a.y, b.y, div);
		return _lerp;
	}
	
	public static function drp(a:Float, b:Float, div:Float):Float {
		return a + (b - a) / div;
	}
	
	public static function lerp(a:Float, b:Float, t:Float):Float {
		return a + (b - a) * t;
	}
	
	public static function float_random(min:Float, max:Float):Float {
		return min + Math.random() * (max - min);
	}
	
	public static function pt_dist(x_0:Float, y_0:Float, x_1:Float, y_1:Float):Float {
		return Math.sqrt(Math.pow(x_1 - x_0, 2) + Math.pow(y_1 - y_0, 2));
	}
	
	public static function cons_text(x:Float, y:Float, text:String, color:Int = 0xFF000000, font_size:Int = 8):FlxText {
		var rtv = new FlxText(x, y, 0, text,font_size);
		rtv.color = color;
		return rtv;
	}
	
	static var _normalized:Vector3D = new Vector3D();
	public static function normalized(x:Float, y:Float):Vector3D {
		_normalized.x = x;
		_normalized.y = y;
		_normalized.z = 0;
		_normalized.normalize();
		return _normalized;
	}
	
	static var _flxpt:FlxPoint = new FlxPoint();
	public static function flxpt(x:Float, y:Float):FlxPoint {
		_flxpt.x = x;
		_flxpt.y = y;
		return _flxpt;
	}
	static var _flxpt2:FlxPoint = new FlxPoint();
	public static function flxpt2(x:Float, y:Float):FlxPoint {
		_flxpt2.x = x;
		_flxpt2.y = y;
		return _flxpt2;
	}
	
}