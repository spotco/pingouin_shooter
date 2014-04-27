package ;

class Stats {

	public static var _current_fish:Int = 0;
	public static var _required_fish:Int = 0;
	public static var _current_lives:Int = 0;
	public static var _max_energy:Int = 100;
	public static var _current_energy:Int = 0;
	
	public static var _stage:Int = 0;
	
	public static function set_stage_params():Void {
		_current_fish = 0;
		_current_energy = _max_energy;
		Stats._current_lives = 5;
		
		if (_stage == 0) {
			_required_fish = 20;
		}
	}
	
}