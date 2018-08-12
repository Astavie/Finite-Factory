extends "res://script/building.gd"

func process(index, x, y, grid, resources):
	var r = grid.get_resources(x, y);
	
	var copper = null;
	var tin = null;
	
	var iron = null;
	var coal = null;
	
	var copper_wire = null;
	var tin_wire = null;
	var iron_wire = null;
	
	for resource in resources:
		resource.tick(1);
		if copper == null and resource.get_type() == 0:
			copper = resource;
		elif tin == null and resource.get_type() == 1:
			tin = resource;
		elif iron == null and resource.get_type() == 3:
			iron = resource;
		elif coal == null and resource.get_type() == 4:
			coal = resource;
		elif copper_wire == null and resource.get_type() == 6:
			copper_wire = resource;
		elif tin_wire == null and resource.get_type() == 7:
			tin_wire = resource;
		elif iron_wire == null and resource.get_type() == 8:
			iron_wire = resource;
	
	if copper != null and tin != null:
		if copper.get_ticks() >= 3 and tin.get_ticks() >= 3:
			var side = get_side(x, y, grid, grid.get_timer(x, y));
			if side != null:
				r.erase(copper);
				r.erase(tin);
				var bronze = resource_class.new(2).tick(-1);
				
				grid.get_resources(x + side.x, y + side.y).append(bronze);
				grid.use(x, y);
				grid.timer(x, y);
	
	if iron != null and coal != null:
		if iron.get_ticks() >= 3 and coal.get_ticks() >= 3:
			var side = get_side(x, y, grid, grid.get_timer(x, y));
			if side != null:
				r.erase(iron);
				r.erase(coal);
				var steel = resource_class.new(5).tick(-1);
				
				grid.get_resources(x + side.x, y + side.y).append(steel);
				grid.use(x, y);
				grid.timer(x, y);
	
	if iron_wire != null and iron_wire.get_ticks() >= 3:
		var side = get_side(x, y, grid, grid.get_timer(x, y));
		if side != null:
			r.erase(iron_wire)
			grid.get_resources(x + side.x, y + side.y).append(resource_class.new(3).tick(-1));
			grid.use(x, y);
			grid.timer(x, y);
	
	if tin_wire != null and tin_wire.get_ticks() >= 3:
		var side = get_side(x, y, grid, grid.get_timer(x, y));
		if side != null:
			r.erase(tin_wire)
			grid.get_resources(x + side.x, y + side.y).append(resource_class.new(1).tick(-1));
			grid.use(x, y);
			grid.timer(x, y);
	
	if copper_wire != null and copper_wire.get_ticks() >= 3:
		var side = get_side(x, y, grid, grid.get_timer(x, y));
		if side != null:
			r.erase(copper_wire)
			grid.get_resources(x + side.x, y + side.y).append(resource_class.new(0).tick(-1));
			grid.use(x, y);
			grid.timer(x, y);
