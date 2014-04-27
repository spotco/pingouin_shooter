package ;

import flash.geom.Vector3D;
import flixel.*;
import enemy.*;
import flixel.text.FlxText;
import flixel.util.FlxPoint;

class Util {
	
	public static var DEG_TO_RAD = Math.PI / 180;
	public static var RAD_TO_DEG = 180 / Math.PI;
	
	public static var FLXPT_ZERO = new FlxPoint(0, 0);
	
	public static function lerp_deg(src:Float, dest:Float, amt:Float) {
		var shortest_angle=((((dest - src) % 360) + 540) % 360) - 180;
		return shortest_angle * amt;
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