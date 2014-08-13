package bgdetail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxPoint;
import flixel.group.FlxGroup;
import openfl.Assets;
import flash.geom.Vector3D;

class TopPenguin extends FlxSprite {
	public static function cons(g:FlxGroup):TopPenguin {
		var rtv:TopPenguin = cast(g.getFirstAvailable(TopPenguin), TopPenguin);
		if (rtv == null) {
			rtv = new TopPenguin();
			g.add(rtv);
		}
		return rtv;
	}
	
	public function new() {
		super();
	}
	
	public function init(x:Float, y:Float):TopPenguin {
		this.setPosition(x, y);
		this.loadGraphic(Assets.getBitmapData("assets/images/top/random_penguin_anim.png"),true,44,86); 
		this.animation.add("stand", [0]);
		this.animation.add("walk", [1,2,3,2], 5);
		this.animation.play("stand");
		_startpt.set(x, y);
		this.set_wander_dx( -1);
		return this;
	}
	
	public function set_wander_dx(dx:Float):TopPenguin {
		_endpt.set(_startpt.x + dx, _startpt.y);
		_initial_start_pt.set(_startpt.x, _startpt.y);
		_initial_end_pt.set(_endpt.x, _endpt.y);
		
		_endpt.set(_startpt.x + dx * Util.float_random(0.1, 1), _startpt.y);
		return this;
	}
	
	public function set_opacity(alpha:Float):TopPenguin {
		this.alpha = alpha;
		return this;
	}
	
	public function set_scale(scale:Float):TopPenguin {
		this.scale.set(scale, scale);
		return this;
	}
	
	private var _initial_start_pt:FlxPoint = new FlxPoint();
	private var _initial_end_pt:FlxPoint = new FlxPoint();
	
	private var _startpt:FlxPoint = new FlxPoint();
	private var _endpt:FlxPoint = new FlxPoint();
	private var _is_moving:Bool = false;
	
	private static var MODE_STARTPT:Int = 0;
	private static var MODE_ENDPT:Int = 1;
	private static var MODE_STARTPT_TO_ENDPT:Int = 2;
	private static var MODE_ENDPT_TO_STARTPT:Int = 3;
	
	private var _mode:Int = MODE_STARTPT;
	private var _do_something_ct:Int = Util.int_random(250, 500);
	
	public override function update():Void {
		super.update();
		
		_do_something_ct = cast(Math.max(50, _do_something_ct - 1),Int);
		var do_something:Int = Util.int_random(0, _do_something_ct);
		
		var cond1 = (do_something <= _do_something_ct / 100) && do_something != 0;
		var cond2 = (do_something >= _do_something_ct / 100 && do_something <= _do_something_ct / 100 * 2) && do_something != 0;
		var cond3 = do_something == 0;
		
		
		if (_mode == MODE_STARTPT) {
			this._is_moving = false;
			if (cond1) {
				this.flipX = false;
				
			} else if (cond2) {
				this.flipX = true;
			
			} else if (cond3) {
				_mode = MODE_STARTPT_TO_ENDPT;
				
			}
			
		} else if (_mode == MODE_ENDPT) {
			this._is_moving = false;
			if (cond1) {
				this.flipX = false;
				
			} else if (cond2) {
				this.flipX = true;
			
			} else if (cond3) {
				_mode = MODE_ENDPT_TO_STARTPT;
			}
			
		} else if (_mode == MODE_STARTPT_TO_ENDPT || _mode == MODE_ENDPT_TO_STARTPT) {
			this._is_moving = true;
			var dp:Vector3D;
			if (_mode == MODE_ENDPT_TO_STARTPT) {
				dp = new Vector3D(_startpt.x - this.x, _startpt.y - this.y);
			} else {
				dp = new Vector3D(_endpt.x - this.x, _endpt.y - this.y);
			}
			if (dp.length <= 0.25) {
				if (_mode == MODE_ENDPT_TO_STARTPT) {
					this.x = _startpt.x;
					this.y = _startpt.y;
					_mode = MODE_STARTPT;
					
					var nv = new Vector3D(_initial_end_pt.x - _initial_start_pt.x, _initial_end_pt.y - _initial_start_pt.y);
					nv.scaleBy(Util.float_random(0.1, 1));
					_endpt.set(_initial_start_pt.x + nv.x, _initial_start_pt.y + nv.y);
					
					
				} else {
					this.x = _endpt.x;
					this.y = _endpt.y;
					_mode = MODE_ENDPT;
					
					var nv = new Vector3D(_initial_start_pt.x - _initial_end_pt.x, _initial_start_pt.y - _initial_end_pt.y);
					nv.scaleBy(Util.float_random(0.1, 1));
					_startpt.set(_initial_end_pt.x + nv.x, _initial_end_pt.y + nv.y);
				}
				_do_something_ct = Util.int_random(250, 500);
				
			} else {
				dp.normalize();
				dp.scaleBy(0.25);
				this.x += dp.x;
				this.y += dp.y;
				if (dp.x < 0) {
					this.flipX = false;
				} else {
					this.flipX = true;
				}
			}
		}
		
		
		if (this._is_moving) {
			this.play("walk");
		} else {
			this.play("stand");
		}
	}
	
		public var _cur_anim:String = "NONE";
		public function play(anim:String):Void {
			if (anim != _cur_anim) {
				_cur_anim = anim;
				this.animation.play(anim);
			}
		}

}