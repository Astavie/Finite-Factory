extends Object

var _type; # 0 - copper, 1 - tin, 2 - bronze, 3 - iron, 4 - coal, 5 - steel, 6 - copper wire, 7 - tin wire, 8 - iron wire
var _texture;
var _progress = 0.0;
var _ticks = 0;

const copper = preload("res://tile/resources/copper.png");
const tin = preload("res://tile/resources/tin.png");
const bronze = preload("res://tile/resources/bronze.png");
const iron = preload("res://tile/resources/iron.png");
const coal = preload("res://tile/resources/coal.png");
const steel = preload("res://tile/resources/steel.png");
const copper_wire = preload("res://tile/resources/copper_wire.png");
const tin_wire = preload("res://tile/resources/tin_wire.png");
const iron_wire = preload("res://tile/resources/iron_wire.png");

func _init(type):
	self._type = type;
	match type:
		0: set_texture(copper);
		1: set_texture(tin);
		2: set_texture(bronze);
		3: set_texture(iron);
		4: set_texture(coal);
		5: set_texture(steel);
		6: set_texture(copper_wire);
		7: set_texture(tin_wire);
		8: set_texture(iron_wire);

func get_type():
	return self._type;

func get_texture():
	return self._texture;

func get_progress():
	return self._progress;

func set_texture(texture):
	self._texture = texture;
	return self;

func progress(delta):
	self._progress += delta;
	return self;

func tick(delta):
	self._ticks += delta;
	self._progress = 0.25 * self._ticks;
	return self;

func get_ticks():
	return self._ticks;
