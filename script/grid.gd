extends Node2D

var tilemap;
var camera;
var gui;

var place;
var output;
var failure;
var finish;
var music;

var offset;

var width;
var height;
var building = null;

var buildings = [];
var resources = [];
var inputs = [];
var outputs = [];
var locked = [];
var usage = [];
var timer = [];

var font;
var time = 0;

var level = 0;
var play = false;
var message = true;

const levels = preload("res://script/levels.gd");

const copper = preload("res://tile/inputs/copper.png");
const tin = preload("res://tile/inputs/tin.png");
const bronze = preload("res://tile/inputs/bronze.png");
const iron = preload("res://tile/inputs/iron.png");
const coal = preload("res://tile/inputs/coal.png");
const steel = preload("res://tile/inputs/steel.png");
const copper_wire = preload("res://tile/inputs/copper_wire.png");
const tin_wire = preload("res://tile/inputs/tin_wire.png");
const iron_wire = preload("res://tile/inputs/iron_wire.png");

func _ready():
	tilemap = get_node("TileMap");
	camera = get_node("Camera2D");
	gui = get_node("CanvasLayer/Control");
	
	place = get_node("Place");
	output = get_node("Output");
	failure = get_node("Failure");
	finish = get_node("Finish");
	music = get_node("Music");
	
	levels.populate_map(level, tilemap);
	
	var rect = tilemap.get_used_rect();
	width = rect.end.x;
	height = rect.end.y;
	offset = Vector2(-24.0 * width, -24.0 * height);
	tilemap.translate(offset);
	
	for x in range(0, width):
		buildings.append([]);
		resources.append([]);
		inputs.append([]);
		outputs.append([]);
		locked.append([]);
		usage.append([]);
		timer.append([]);
		for y in range(0, height):
			buildings[x].append(null);
			resources[x].append([]);
			inputs[x].append(-1);
			outputs[x].append(0);
			locked[x].append(false);
			usage[x].append(false);
			timer[x].append(0);
	
	levels.populate_buildings(level, buildings, inputs, locked);
	levels.populate_outputs(level, outputs);
	
	var label = Label.new();
	font = label.get_font("");

func _input(event):
	if not play and not message and event is InputEventMouseButton:
		var inside = event.get_position().y <= camera.get_viewport_rect().end.y - 64;
		var pos = (camera.get_global_mouse_position() - offset) / 48;
		var x = int(floor(pos.x));
		var y = int(floor(pos.y));
		var tile = Vector2(x, y) * 48 + offset;

		if event.get_button_index() == BUTTON_LEFT:
			if x >= 0 and y >= 0 and x < width and y < height and inside and tilemap.get_cell(x, y) >= 0:
				if not event.is_pressed():
					if building != null and tilemap.get_cell(x, y) == 0:
						place.play();
						var angle = (tile + Vector2(24, 24)).angle_to_point(camera.get_global_mouse_position());
						buildings[x][y] = building;
						tilemap.set_cell(x, y, building.get_index(angle));
					else:
						building = null;
				elif buildings[x][y] != null and not locked[x][y]:
					place.play();
					buildings[x][y] = null;
					resources[x][y].clear();
					tilemap.set_cell(x, y, 0);
			if not event.is_pressed():
				building = null;

func handle_building(building):
	if not play and not message:
		self.building = building;

func _process(delta):
	if play:
		for x in range(0, width):
			for y in range(0, height):
				if buildings[x][y] != null:
					buildings[x][y].progress(tilemap.get_cell(x, y), x, y, self, resources[x][y], delta);
		time += delta;
		while time >= 0.25:
			time -= 0.25;
			var _resources = [];
			for x in range(0, width):
				_resources.append([]);
				for y in range(0, height):
					_resources[x].append(resources[x][y].duplicate());
			for x in range(0, width):
				for y in range(0, height):
					if buildings[x][y] != null and not buildings[x][y].top():
						buildings[x][y].process(tilemap.get_cell(x, y), x, y, self, _resources[x][y]);
			for x in range(0, width):
				for y in range(0, height):
					if buildings[x][y] != null and buildings[x][y].top():
						buildings[x][y].process(tilemap.get_cell(x, y), x, y, self, _resources[x][y]);
	update();

func _draw():
	for x in range(0, width):
		for y in range(0, height):
			if buildings[x][y] != null:
				buildings[x][y].draw(tilemap.get_cell(x, y), x, y, self);
	
	for x in range(0, width):
		for y in range(0, height):
			if buildings[x][y] != null and buildings[x][y].top():
				buildings[x][y].get_icon().draw(get_canvas_item(), Vector2(x, y) * 48 + offset);
	
	for x in range(0, width):
		for y in range(0, height):
			if inputs[x][y] != -1:
				var texture = copper;
				match inputs[x][y]:
					0: texture = copper;
					1: texture = tin;
					2: texture = bronze;
					3: texture = iron;
					4: texture = coal;
					5: texture = steel;
					6: texture = copper_wire;
					7: texture = tin_wire;
					8: texture = iron_wire;
				if tilemap.get_cell(x - 1, y) == -1:
					texture.draw(get_canvas_item(), Vector2(x, y) * 48 + offset);
				if tilemap.get_cell(x + 1, y) == -1:
					texture.draw(get_canvas_item(), Vector2(x, y) * 48 + offset + Vector2(24, 0));
					if outputs[x][y] > 0:
						draw_string(font, Vector2(x + 1, y) * 48 + offset + Vector2(4, 24 + font.get_height() / 3), str(outputs[x][y]));
	
	if building != null:
		var pos = (camera.get_global_mouse_position() - offset) / 48;
		var x = int(floor(pos.x));
		var y = int(floor(pos.y));
		var tile = Vector2(x, y) * 48 + offset;
		
		if x >= 0 and y >= 0 and x < width and y < height and tilemap.get_cell(x, y) == 0:
			var angle = (tile + Vector2(24, 24)).angle_to_point(camera.get_global_mouse_position());
			tilemap.tile_set.tile_get_texture(building.get_index(angle)).draw(get_canvas_item(), tile, Color(1, 1, 1, 0.5));
		else:
			building.get_icon().draw(get_canvas_item(), camera.get_global_mouse_position() - Vector2(24, 24));

func get_width():
	return width;

func get_height():
	return height;

func get_building(x, y):
	if x < 0 or y < 0 or x >= width or y >= height:
		return null;
	return buildings[x][y];

func get_resources(x, y):
	if x < 0 or y < 0 or x >= width or y >= height:
		return [];
	return resources[x][y];

func get_offset():
	return offset;

func get_index(x, y):
	return tilemap.get_cell(x, y);

func get_input(x, y):
	return inputs[x][y];

func output(x, y):
	if outputs[x][y] == 0:
		return;
	var good = output;
	if outputs[x][y] == 1:
		good = finish;
	outputs[x][y] -= 1;
	for x in range(0, width):
		for y in range(0, height):
			if outputs[x][y] > 0:
				good.play();
				return;
	for x in range(0, width):
		for y in range(0, height):
			if tilemap.get_cell(x, y) != -1 and not usage[x][y]:
				failure.play();
				gui.failure();
				return;
	good.play();
	gui.gratz();
	if level == 11:
		music.stop();

func pause():
	play = false;

func play():
	time = 0;
	self.building = null;
	for x in range(0, width):
		for y in range(0, height):
			resources[x][y].clear();
			outputs[x][y] = 0;
			usage[x][y] = false;
			timer[x][y] = 0;
	levels.populate_outputs(level, outputs);
	play = true;

func get_level():
	return level;

func finish():
	if not music.is_playing():
		music.play();
	message = false;

func use(x, y):
	usage[x][y] = true;

func get_timer(x, y):
	return timer[x][y];

func timer(x, y):
	timer[x][y] += 1;

func next():
	if level == 11:
		get_tree().quit();
	else:
		level += 1;
		
		building = null;
		play = false;
		message = true;
		
		if not levels.retain(level):
			buildings = [];
			inputs = [];
			locked = [];
		resources = [];
		outputs = [];
		usage = [];
		timer = [];
		
		tilemap.translate(-offset);
		if not levels.retain(level):
			tilemap.clear();
		
		levels.populate_map(level, tilemap);
		
		var rect = tilemap.get_used_rect();
		width = rect.end.x;
		height = rect.end.y;
		offset = Vector2(-24.0 * width, -24.0 * height);
		tilemap.translate(offset);
		
		for x in range(0, width):
			if not levels.retain(level):
				buildings.append([]);
				inputs.append([]);
				locked.append([]);
			resources.append([]);
			outputs.append([]);
			usage.append([]);
			timer.append([]);
			for y in range(0, height):
				if not levels.retain(level):
					buildings[x].append(null);
					inputs[x].append(-1);
					locked[x].append(false);
				resources[x].append([]);
				outputs[x].append(0);
				usage[x].append(false);
				timer[x].append(0);
		
		levels.populate_buildings(level, buildings, inputs, locked);
		levels.populate_outputs(level, outputs);
