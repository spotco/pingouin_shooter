package ;

import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import openfl.Assets;
import particle.*;
class GameEndState extends FlxState {

	var _player:FlxSprite;
	var _baby:FlxSprite;
	var _mode:Int = 0;
	var _ct:Int = 0;
	var _fadeout:FlxSprite;
	
	var _theend:FlxText;
	var _press_to_continue:FlxText;
	
	override public function create():Void {
		super.create();
		this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_bg.png")));
		this.add(new FlxSprite(0, 0, Assets.getBitmapData("assets/images/top/top_smallcrowd.png")));
		
		_player = TopState.cons_penguin(FlxG.width * 0.64, FlxG.height * 0.65,this);
		_baby = TopState.cons_penguin(FlxG.width * 0.2, FlxG.height * 0.65, this);
		_baby.flipX = true;
		_mode = -1;
		
		_fadeout = new FlxSprite();
		_fadeout.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		_fadeout.alpha = 1;
		this.add(_fadeout);
		
		_theend = Util.cons_text(FlxG.width * 0.5-75, FlxG.height * 0.5, "The End", 0xFFFFFFFF, 32);
		_theend.visible = false;
		this.add(_theend);
		
		_press_to_continue = Util.cons_text(FlxG.width * 0.5 - 55, FlxG.height * 0.6, "(Press Z to restart)", 0xFFFFFFFF, 10);
		_press_to_continue.visible = false;
		this.add(_press_to_continue);
	}
	
	override public function update():Void {
		super.update();
		if (_mode == -1){ 
			_fadeout.alpha -= 0.05;
			if (_fadeout.alpha <= 0) {
				_mode = 0;
			}
			
		} else if (_mode == 0) {
			if (_baby.x < FlxG.width * 0.5) {
				_baby.x += 3;
				_baby.animation.play("walk");
				
			} else {
				_player.animation.play("barf");
				_baby.animation.play("barf");
				_mode = 1;
				_ct = 100;
			}
		} else if (_mode == 1) {
			_ct--;
			if (_ct <= 0) {
				_player.animation.play("walk");
				_baby.animation.play("stand");
				_mode = 2;
			}
			
		} else if (_mode == 2) { 
			_player.x -= 3;
			if (_player.x < FlxG.width * 0.3 && _baby.x < FlxG.width * 0.64) {
				_baby.animation.play("walk");
				_baby.x += 1.5;
			} else if (_baby.x >= FlxG.width * 0.64) {
				_mode = 3;
				_baby.animation.play("stand");
				_player.animation.play("stand");
			}
		} else if (_mode == 3) {
			_fadeout.alpha += 0.05;
			if (_fadeout.alpha >= 1) {
				_theend.visible = true;
				_press_to_continue.visible = true;
			}
			if (FlxG.keys.justPressed.Z) {
				Stats._stage = 0;
				Stats.set_stage_params();
				FlxG.switchState(new TopState());
			}
		}
	}
	
}