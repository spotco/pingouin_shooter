package pickup;
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

class BasePickup extends FlxSprite {
	public function pickup_effect():Void { }
	public function game_update():Void {}
}