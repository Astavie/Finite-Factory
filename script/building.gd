extends Object

const resource_class = preload("res://script/resource.gd");

var _icon;
var _index;

func get_icon():
	return self._icon;

func set_icon(icon):
	self._icon = icon;
	return self;

func get_index(angle):
	return self._index;

func get_default_index():
	return self._index;

func set_index(index):
	self._index = index;
	return self;

func progress(index, x, y, grid, resources, delta):
	for resource in resources:
		resource.progress(delta);

func process(index, x, y, grid, resources):
	var r = grid.get_resources(x, y);
	for resource in resources:
		resource.tick(1);
		if resource.get_ticks() >= 3:
			var side = get_side(x, y, grid, grid.get_timer(x, y));
			if side != null:
				r.erase(resource);
				grid.get_resources(x + side.x, y + side.y).append(resource_class.new(resource.get_type()).tick(-1));
				grid.use(x, y);
				grid.timer(x, y);

func draw(index, x, y, grid):
	pass;

func can_receive(index, xa, ya):
	return true;

func want_receive(index, x, y, grid, xa, ya):
	return can_receive(index, xa, ya) and grid.get_resources(x, y).size() <= 4;

func top():
	return true;

func infinite():
	return true;

func get_side(x, y, grid, timer):
	var sides = [];
	if (grid.get_building(x - 1, y) != null and not grid.get_building(x - 1, y).top() and grid.get_building(x - 1, y).want_receive(grid.get_index(x - 1, y), x - 1, y, grid, 1, 0)):
		sides.append(Vector2(-1, 0));
	if (grid.get_building(x, y - 1) != null and not grid.get_building(x, y - 1).top() and grid.get_building(x, y - 1).want_receive(grid.get_index(x, y - 1), x, y - 1, grid, 0, 1)):
		sides.append(Vector2(0, -1));
	if (grid.get_building(x + 1, y) != null and not grid.get_building(x + 1, y).top() and grid.get_building(x + 1, y).want_receive(grid.get_index(x + 1, y), x + 1, y, grid, -1, 0)):
		sides.append(Vector2(1, 0));
	if (grid.get_building(x, y + 1) != null and not grid.get_building(x, y + 1).top() and grid.get_building(x, y + 1).want_receive(grid.get_index(x, y + 1), x, y + 1, grid, 0, -1)):
		sides.append(Vector2(0, 1));
	
	if sides.size() == 0:
		return null;
	return sides[timer % sides.size()];
