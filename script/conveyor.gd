extends "res://script/building.gd"

func get_index(angle):
	return int(fposmod(floor((2 * angle) / PI + 0.5), 4)) + get_default_index();

func progress(index, x, y, grid, resources, delta):
	var des = get_destination(index);
	var building = grid.get_building(x + des.x, y + des.y);
	
	var i = 0;
	while i < resources.size():
		var resource = resources[i];
		var next = 0.75;
		if (i > 0):
			next = resources[i - 1].get_progress() - 0.25;
		else:
			if building != null and building.want_receive(grid.get_index(x + des.x, y + des.y), x + des.x, y + des.y, grid, -des.x, -des.y):
				if building.infinite():
					next = 1;
				else:
					var res = grid.get_resources(x + des.x, y + des.y);
					if (res.size() > 0):
						next = res[res.size() - 1].get_progress() + 0.75;
					else:
						next = 1;
		
		resource.progress(max(min(delta, next - resource.get_progress()), 0));
		i += 1;

func process(index, x, y, grid, resources):
	var r = grid.get_resources(x, y);
	var des = get_destination(index);
	var building = grid.get_building(x + des.x, y + des.y);
	
	var i = 0;
	while i < resources.size():
		var resource = resources[i];
		var next = 3;
		if (i > 0):
			next = resources[i - 1].get_ticks() - 1;
		else:
			if building != null and building.want_receive(grid.get_index(x + des.x, y + des.y), x + des.x, y + des.y, grid, -des.x, -des.y):
				if building.infinite():
					next = 4;
				else:
					var res = grid.get_resources(x + des.x, y + des.y);
					if (res.size() > 0):
						next = res[res.size() - 1].get_ticks() + 3;
					else:
						next = 4;
		
		var down = 0;
		if (resource.get_progress() * 4 - resource.get_ticks() > 0.5):
			down = 1;
		resource.tick(max(min(1, next - resource.get_ticks()), down));
		if resource.get_ticks() >= 4 and building != null and building.can_receive(grid.get_index(x + des.x, y + des.y), -des.x, -des.y):
			grid.get_resources(x + des.x, y + des.y).append(resource_class.new(resource.get_type()).tick(resource.get_ticks() - 4));
			grid.use(x, y);
			r.erase(resource);
		i += 1;
	
	var source = get_source(index);
	var input = grid.get_input(x, y);
	if (input != -1):
		if grid.get_index(x - 1, y) == -1:
			if resources.size() > 0 and resources[resources.size() - 1].get_ticks() < 2:
				return;
			
			r.append(resource_class.new(input));
		if grid.get_index(x + 1, y) == -1:
			for resource in resources:
				if resource.get_type() == input and resource.get_ticks() >= 3:
					grid.output(x, y);
					grid.use(x, y);
					r.erase(resource);

func draw(index, x, y, grid):
	var source = get_source(index);
	var des = get_destination(index);
	
	var tile = Vector2(x, y) * 48 + grid.get_offset() + Vector2(18, 18);
	var resources = grid.get_resources(x, y);
	for resource in resources:
		var progress = (resource.get_progress() - 0.375) * 48;
		var xa;
		var ya;
		if progress > 0:
			xa = des.x;
			ya = des.y;
		else:
			xa = -source.x;
			ya = -source.y;
		resource.get_texture().draw(grid.get_canvas_item(), tile + Vector2(progress * xa, progress * ya));

func get_destination(index):
	index -= get_default_index();
	var xa = 0;
	var ya = 0;
	
	match index:
		0: xa = -1;
		1: ya = -1;
		2: xa = 1;
		3: ya = 1;
	return Vector2(xa, ya);

func get_source(index):
	return -get_destination(index);

func want_receive(index, x, y, grid, xa, ya):
	var resources = grid.get_resources(x, y);
	return can_receive(index, xa, ya) and (resources.size() == 0 || resources[resources.size() - 1].get_ticks() >= 0);

func can_receive(index, xa, ya):
	var source = get_source(index);
	return source.x == xa and source.y == ya;

func top():
	return false;

func infinite():
	return false;
