package pickup;
import flash.display.BlendMode;
import flash.filters.BitmapFilter;
import flixel.effects.FlxSpriteFilter;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import openfl.Assets;
import flash.filters.GlowFilter;
import flash.filters.BitmapFilter;

class OneUpPickup extends GoldFishPickup {
	var _glow:GlowFilter;
	var _fltr:FlxSpriteFilter;
	var _t:Float = 0;   
	
	public static function cons(g:FlxGroup):OneUpPickup {
		var rtv:OneUpPickup = cast(g.getFirstAvailable(OneUpPickup), OneUpPickup);
		if (rtv == null) {
			rtv = new OneUpPickup();
			g.add(rtv);
		}
		return rtv;
	}

	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/fx/1up.png")); 
		_glow = new GlowFilter(0xFF00FF00, 0.8, 15, 15, 2, 1, false, false);
		_fltr = new FlxSpriteFilter(this, 20, 20);
		_fltr.addFilter(_glow);
	}
	
	public override function game_update():Void {
		super.game_update();
		this.flipX = false;
		
		_t += 0.1 ;
		_glow.alpha = (Math.sin(_t) + 1) / 2;
		_fltr.applyFilters();
	}
	
	public override function pickup_effect():Void { 
		this.kill();
		Stats._current_lives++;
	}
}