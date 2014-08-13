package bgdetail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import openfl.Assets;

class BgKelp extends FlxSprite {
	public static function cons(g:FlxGroup):BgKelp {
		var rtv:BgKelp = cast(g.getFirstAvailable(BgKelp), BgKelp);
		if (rtv == null) {
			rtv = new BgKelp();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function init(ct:Int):BgKelp {
		this.loadGraphic(Assets.getBitmapData("assets/images/bottom/kelp_anim.png"),true,37,286); 
		if (ct == 0) {
			this.animation.add("stand", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], 10, true);
			this.setPosition(200, 100);
			
		} else if (ct == 1) {
			this.animation.add("stand", [10,11,12,13,14,0,1,2,3,4,5,6,7,8,9], 11, true);
			this.setPosition(400, 180);
			
		} else {
			this.animation.add("stand", [13,14,0,1,2,3,4,5,6,7,8,9,10,11,12], 9, true);
			this.setPosition(650, 160);
		}
		this.animation.play("stand");
		return this;
	}
	
	public function new() {
		super();
	}
}