package enemy;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.FlxObject;
import flixel.*;
import openfl.Assets;

class BaseEnemy extends FlxSprite {
	
	public function hit():Void { }
	public function is_dead():Bool { return true; }
	public function death_effect():Void { }
	
	public function game_update():Void{}
}