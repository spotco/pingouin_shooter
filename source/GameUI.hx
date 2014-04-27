package ;
import flash.geom.Vector3D;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxVector;
import openfl.Assets;
import enemy.*;
import pickup.BasePickup;

class GameUI extends FlxGroup {

	public var _fadeout:FlxSprite;
	
	public var _items_disp:FlxGroup;
	
	var _fish_disp:FlxText;
	var _lives_disp:FlxText;
	var _energy_disp:FlxText;
	
	public function new() {
		super();
		_fadeout = new FlxSprite();
		_fadeout.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		_fadeout.alpha = 0;
		this.add(_fadeout);
		
		_items_disp = new FlxGroup();
		this.add(_items_disp);
		
		var items_disp_bg = new FlxSprite();
		items_disp_bg.makeGraphic(160, 50, 0x99666666);
		items_disp_bg.x = 10;
		items_disp_bg.y = 10;
		_items_disp.add(items_disp_bg);
		
		_fish_disp = new FlxText(15, 15,0,"",15);
		_items_disp.add(_fish_disp);
		
		_lives_disp = new FlxText(15, 32.5,0,"",15);
		_items_disp.add(_lives_disp);
		
		var energy_disp_bg = new FlxSprite();
		energy_disp_bg.makeGraphic(300, 60, 0x99666666);
		energy_disp_bg.x = 10;
		energy_disp_bg.y = 460;
		_items_disp.add(energy_disp_bg);
		
		_energy_disp = new FlxText(15, 465,0,"",24);
		_items_disp.add(_energy_disp);
		
		this.game_update();
	}
	
	public function game_update():Void {
		_fish_disp.text = "Fish: " + Stats._current_fish + "/" + Stats._required_fish;
		if (Stats._current_fish >= Stats._required_fish) {
			_fish_disp.color = 0xFF00FF00;
		} else {
			_fish_disp.color = 0xFFFFFFFF;
		}
		
		_lives_disp.text = "Lives: " + Stats._current_lives;
		_energy_disp.text = "Energy: " + Stats._current_energy + "/" + Stats._max_energy;
	}
	
}