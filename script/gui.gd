extends Control

const levels = preload("res://script/levels.gd");

const pause = preload("res://tile/pause.png");
const play = preload("res://tile/play.png");

var buildings = [];
var sprites = [];
var camera;
var offset;

var button;
var label;
var nine;
var voice;
var title;

var message = [];
var delay = 0;
var finished = false;
var gratz = false;
var failure = false;

var number;

func _ready():
	randomize();
	number = randi() % 898 + 101;
	
	levels.populate_toolbar(get_parent().get_parent().get_level(), buildings);
	levels.populate_briefing(get_parent().get_parent().get_level(), message, number);
	
	offset = -24.0 * buildings.size();
	for i in range(0, buildings.size()):
		var sprite = Sprite.new();
		sprite.texture = buildings[i].get_icon();
		add_child(sprite);
		sprite.translate(Vector2(offset + 24.0 + 48.0 * i, 0.0));
		sprites.append(sprite);
	
	camera = get_node("../../Camera2D");
	button = get_node("Sprite");
	label = get_node("../Label");
	nine = get_node("../NinePatchRect");
	voice = get_node("Voice");
	title = get_node("../Name");

func _process(delta):
	if not finished and message.front().size() > 0:
		delay += delta;
		while delay >= 0.02:
			var c = message.front().front();
			label.set_text(str(label.get_text(), c));
			if c == ',':
				delay -= 0.2;
			elif c == '.' or c == '!' or c == '?':
				delay -= 0.4;
			elif c != ' ':
				voice.play();
			
			message.front().pop_front();
			if message.front().size() == 0:
				delay = 0;
				return;
			delay -= 0.02;

func _input(event):
	if event is InputEventMouseButton and event.get_button_index() == BUTTON_LEFT and event.is_pressed():
		if finished:
			var end = camera.get_viewport_rect().end;
			var pos = event.get_position() - Vector2(end.x / 2, end.y - 64);
			if pos.y > 9 and pos.y <= 57:
				var index = int(floor((pos.x - offset) / 48));
				if index >= 0 and index < buildings.size():
					get_parent().get_parent().handle_building(buildings[index]);
			if pos.y > -47 and pos.y <= 1 and pos.x >= -24 and pos.x < 24:
				if button.texture == pause:
					button.texture = play;
					get_parent().get_parent().pause();
					nine.set_visible(true);
					for sprite in sprites:
						sprite.set_visible(true);
				else:
					button.texture = pause;
					get_parent().get_parent().play();
					nine.set_visible(false);
					for sprite in sprites:
						sprite.set_visible(false);
		elif message.front().size() == 0:
			delay = 0;
			label.set_text("");
			message.pop_front();
			if message.size() == 0:
				if not gratz:
					levels.populate_name(get_parent().get_parent().get_level(), title);
					failure = false;
					button.set_visible(true);
					get_parent().get_parent().finish();
					finished = true;
					if button.texture == pause:
						button.texture = play;
						get_parent().get_parent().pause();
						nine.set_visible(true);
						for sprite in sprites:
							sprite.set_visible(true);
				else:
					get_parent().get_parent().next();
					nine.set_visible(true);
					for child in sprites:
						remove_child(child);
					button.texture = play;
					get_parent().get_parent().pause();
					
					buildings = [];
					sprites = [];
					message = [];
					
					finished = false;
					gratz = false;
					
					levels.populate_toolbar(get_parent().get_parent().get_level(), buildings);
					levels.populate_briefing(get_parent().get_parent().get_level(), message, number);
					
					offset = -24.0 * buildings.size();
					for i in range(0, buildings.size()):
						var sprite = Sprite.new();
						sprite.texture = buildings[i].get_icon();
						add_child(sprite);
						sprite.translate(Vector2(offset + 24.0 + 48.0 * i, 0.0));
						sprites.append(sprite);
					
					button.set_visible(false);
		else:
			voice.play();
			delay = 0;
			for c in message.front():
				label.set_text(str(label.get_text(), c));
			message.front().clear();

func gratz():
	if not gratz and not failure:
		title.set_text("");
		gratz = true;
		finished = false;
		levels.populate_congratulations(get_parent().get_parent().get_level(), message, number);
		button.set_visible(false);

func failure():
	if not gratz and not failure:
		title.set_text("");
		failure = true;
		finished = false;
		levels.populate_failure(get_parent().get_parent().get_level(), message, number);
		button.set_visible(false);
