package pickup;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import openfl.Assets;

class GoldFishPickup extends BasePickup {
	
	public static function cons(g:FlxGroup):GoldFishPickup {
		var rtv:GoldFishPickup = cast(g.getFirstAvailable(GoldFishPickup), GoldFishPickup);
		if (rtv == null) {
			rtv = new GoldFishPickup();
			g.add(rtv);
		}
		return rtv;
	}

	public function new() {
		super();
		this.loadGraphic(Assets.getBitmapData("assets/images/char/goldfish.png")); 
	}
	
	var _ct:Float = 0;
	var _vel:FlxPoint = new FlxPoint();
	public function init(x:Float,y:Float) {
		this.reset(x, y);
		_ct = 0;
		_vel.x = Util.float_random( -0.5, 0.5);
		_vel.y = Util.float_random( -0.5, 0.5);
		_magneted = false;
	}
	
	var _flash_ct = 0;
	var _magneted:Bool = false;
	public override function game_update():Void {
		
		if (Util.flxpt(this.x, this.y).distanceTo(Util.flxpt2(GameState.instance._player.get_bullet_spawn().x,GameState.instance._player.get_bullet_spawn().y)) < 60) {
			_magneted = true;
		}
		
		this.x += _vel.x;
		this.y += _vel.y;
		
		this.flipX = (_vel.x > 0);
		//this.scale.x = (_vel.x > 0) ? -1 : 1;
		
		if (_magneted) {
			var player = GameState.instance._player.get_bullet_spawn();
			var v = Util.normalized(player.x - this.x, player.y - this.y);
			v.scaleBy(5.5);
			_vel.x = v.x;
			_vel.y = v.y;
		}
		
		if (_flash_ct % 100 == 0) {
			_vel.x = Util.float_random( -0.5, 0.5);
			_vel.y = Util.float_random( -0.5, 0.5);
		}
		
		_ct += 0.001;
		_flash_ct++;
		if (_ct > 0.7) {
			if (_flash_ct % 10 == 0) {
				this.alpha = this.alpha == 1 ? 0.6 : 1;
			}
			
		} else {
			this.alpha = 1;
		}
		
		if (_ct >= 1) {
			this.kill();
		}
	}
	
	public override function pickup_effect():Void { 
		this.kill();
		Stats._current_fish++;
		Stats._collected_fish++;
	}
	
}