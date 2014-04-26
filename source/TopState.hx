package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import openfl.Assets;

class TopState extends FlxState {
	
	var _player:FlxSprite;
	
	override public function create():Void {
		super.create();
		
		var bg = new FlxSprite(0,0,Assets.getBitmapData("assets/images/top/top_bg.png"));
		this.add(bg);
		
		var mom = new FlxSprite(FlxG.width*0.2, FlxG.height*0.65, Assets.getBitmapData("assets/images/char/top_character_mom.png"));
		this.add(mom);
		
		_player = new FlxSprite(FlxG.width * 0.5, FlxG.height * 0.65, Assets.getBitmapData("assets/images/char/top_character_player.png"));
		this.add(_player);
	}

	override public function update():Void {
		super.update();
		if (FlxG.keys.pressed.LEFT && _player.x > FlxG.width * 0.25) {
			_player.x -= 5; 
			_player.flipX = false;
		} else if (FlxG.keys.pressed.RIGHT && _player.x < FlxG.width * 0.675 ) {
			_player.x += 5;
			_player.flipX = true;
		}
		
		if (_player.x > FlxG.width * 0.67) {
			FlxG.switchState(new GameState());
		}
	}
}