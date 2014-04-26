package ;

import flash.geom.Vector3D;
import flixel.*;

class Util {
	
	public static var DEG_TO_RAD = Math.PI / 180;
	public static var RAD_TO_DEG = 180 / Math.PI;
	
	public static function lerp_deg(src:Float, dest:Float, amt:Float) {
		var shortest_angle=((((dest - src) % 360) + 540) % 360) - 180;
		return shortest_angle * amt;
	}
	
}