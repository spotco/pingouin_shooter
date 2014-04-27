package enemy;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.FlxObject;
import flixel.*;
import openfl.Assets;

class BaseEnemy extends FlxSprite {
	
	var _healthbar:FlxBar;
	
	public function hit():Void {
		this.health--;
		if (this.health > 0 && _healthbar == null) {
			_healthbar = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, 30, 4, this, "health", 0, this.health + 1);
			GameState.instance._healthbars.add(_healthbar);
		}
	}
	
	public override function kill():Void {
		super.kill();
		GameState.instance._healthbars.remove(_healthbar);
		_healthbar = null;
	}
	public function is_dead():Bool { return this.health <= 0; }
	public function death_effect():Void { }
	
	public function game_update():Void {
		if (_healthbar != null) this.track_healthbar();
	}
	
	public function track_healthbar():Void {
		_healthbar.trackParent(0, 0);
	}
}