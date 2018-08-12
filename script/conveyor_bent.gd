extends "res://script/conveyor.gd"

var _clockwise = 1;

func set_anticlockwise():
	self._clockwise = -1;
	return self;

func get_source(index):
	var des = get_destination(index);
	return Vector2(-self._clockwise * des.y, self._clockwise * des.x);
