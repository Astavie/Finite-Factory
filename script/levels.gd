extends Object

const building_class = preload("res://script/building.gd");
const conveyor_class = preload("res://script/conveyor.gd");
const conveyor_bent_class = preload("res://script/conveyor_bent.gd");
const furnace_class = preload("res://script/furnace.gd");

static func retain(level):
	return level == 4;

static func populate_map(level, tilemap):
	match level:
		0:
			tilemap.set_cell(0, 0, 4);
			tilemap.set_cell(1, 0, 4);
			tilemap.set_cell(2, 0, 4);
			tilemap.set_cell(0, 2, 0);
			tilemap.set_cell(1, 2, 0);
			tilemap.set_cell(2, 2, 0);
		1:
			tilemap.set_cell(2, 0, 0);
			tilemap.set_cell(3, 0, 0);
			tilemap.set_cell(4, 0, 0);
			tilemap.set_cell(2, 1, 0);
			tilemap.set_cell(2, 2, 0);
			tilemap.set_cell(0, 3, 0);
			tilemap.set_cell(1, 3, 0);
			tilemap.set_cell(2, 3, 0);
		2:
			tilemap.set_cell(0, 0, 4);
			tilemap.set_cell(1, 0, 4);
			tilemap.set_cell(2, 0, 4);
			tilemap.set_cell(3, 0, 4);
			tilemap.set_cell(4, 0, 4);
			tilemap.set_cell(5, 0, 4);
			tilemap.set_cell(1, 1, 0);
			tilemap.set_cell(2, 1, 0);
			tilemap.set_cell(3, 1, 0);
			tilemap.set_cell(4, 1, 0);
			tilemap.set_cell(0, 2, 4);
			tilemap.set_cell(1, 2, 4);
			tilemap.set_cell(2, 2, 4);
			tilemap.set_cell(3, 2, 4);
			tilemap.set_cell(4, 2, 4);
			tilemap.set_cell(5, 2, 4);
		3:
			tilemap.set_cell(0, 0, 0);
			tilemap.set_cell(0, 2, 0);
			tilemap.set_cell(4, 2, 0);
			
			for x in range(1, 4):
				for y in range(0, 3):
					tilemap.set_cell(x, y, 0);
			tilemap.set_cell(2, 1, 14);
		4:
			tilemap.set_cell(4, 0, 0);
		5:
			tilemap.set_cell(2, 0, 0);
			tilemap.set_cell(3, 0, 0);
			tilemap.set_cell(4, 0, 0);
			tilemap.set_cell(5, 0, 0);
			tilemap.set_cell(6, 0, 0);
			tilemap.set_cell(1, 1, 0);
			tilemap.set_cell(5, 1, 0);
			tilemap.set_cell(1, 2, 0);
			tilemap.set_cell(5, 2, 0);
			tilemap.set_cell(1, 3, 0);
			tilemap.set_cell(5, 3, 0);
			tilemap.set_cell(0, 4, 0);
			tilemap.set_cell(1, 4, 0);
			tilemap.set_cell(2, 4, 0);
			tilemap.set_cell(3, 4, 0);
			tilemap.set_cell(4, 4, 0);
			
			for x in range(2, 5):
				for y in range(1, 4):
					tilemap.set_cell(x, y, 0);
			tilemap.set_cell(3, 2, 14);
		6:
			tilemap.set_cell(1, 0, 0);
			tilemap.set_cell(2, 0, 0);
			tilemap.set_cell(3, 0, 0);
			tilemap.set_cell(4, 0, 0);
			tilemap.set_cell(5, 0, 0);
			tilemap.set_cell(0, 1, 0);
			tilemap.set_cell(1, 1, 0);
			tilemap.set_cell(2, 1, 0);
			tilemap.set_cell(3, 1, 0);
			tilemap.set_cell(4, 1, 0);
			tilemap.set_cell(1, 2, 0);
			tilemap.set_cell(2, 2, 0);
			tilemap.set_cell(3, 2, 0);
			tilemap.set_cell(4, 2, 0);
			tilemap.set_cell(5, 2, 0);
		7:
			tilemap.set_cell(0, 0, 0);
			tilemap.set_cell(1, 0, 0);
			tilemap.set_cell(2, 0, 0);
			tilemap.set_cell(3, 0, 0);
			tilemap.set_cell(4, 0, 0);
			tilemap.set_cell(1, 1, 0);
			tilemap.set_cell(2, 1, 0);
			tilemap.set_cell(3, 1, 0);
			tilemap.set_cell(4, 1, 0);
			tilemap.set_cell(5, 1, 0);
			tilemap.set_cell(0, 2, 0);
			tilemap.set_cell(1, 2, 0);
			tilemap.set_cell(2, 2, 0);
			tilemap.set_cell(3, 2, 0);
			tilemap.set_cell(4, 2, 0);
		8:
			tilemap.set_cell(0, 0, 0);
			tilemap.set_cell(4, 0, 0);
			tilemap.set_cell(0, 2, 0);
			tilemap.set_cell(4, 2, 0);
			
			for x in range(1, 4):
				for y in range(0, 3):
					tilemap.set_cell(x, y, 0);
			tilemap.set_cell(2, 1, 14);
		9:
			tilemap.set_cell(0, 0, 0);
			tilemap.set_cell(0, 2, 0);
			tilemap.set_cell(0, 4, 0);
			tilemap.set_cell(4, 0, 0);
			tilemap.set_cell(4, 4, 0);
			
			for x in range(1, 4):
				for y in range(0, 5):
					tilemap.set_cell(x, y, 0);
			tilemap.set_cell(2, 3, 14);
		10:
			tilemap.set_cell(1, 0, 0);
			tilemap.set_cell(2, 0, 0);
			tilemap.set_cell(2, 1, 0);
			tilemap.set_cell(2, 2, 0);
			tilemap.set_cell(0, 3, 0);
			tilemap.set_cell(1, 3, 0);
			tilemap.set_cell(2, 3, 0);
			tilemap.set_cell(1, 4, 0);
			tilemap.set_cell(3, 0, 0);
			tilemap.set_cell(2, 4, 0);
			tilemap.set_cell(3, 4, 0);
			tilemap.set_cell(6, 1, 4);
			tilemap.set_cell(6, 3, 4);
			
			for x in range(2, 6):
				for y in range(1, 4):
					tilemap.set_cell(x, y, 0);
			tilemap.set_cell(5, 1, 14);
			tilemap.set_cell(5, 3, 14);
		11:
			tilemap.set_cell(1, 0, 0);
			tilemap.set_cell(0, 1, 0);
			tilemap.set_cell(1, 1, 0);
			tilemap.set_cell(0, 3, 0);
			tilemap.set_cell(1, 3, 0);
			tilemap.set_cell(1, 4, 0);
			tilemap.set_cell(5, 0, 0);
			tilemap.set_cell(5, 4, 0);
			tilemap.set_cell(2, 4, 0);
			tilemap.set_cell(4, 4, 0);
			
			for x in range(2, 5):
				for y in range(0, 4):
					tilemap.set_cell(x, y, 0);
			tilemap.set_cell(3, 2, 14);

static func populate_buildings(level, buildings, inputs, locked):
	var conveyor_straight = conveyor_class.new().set_icon(load("res://tile/conveyor_straight/icon.png")).set_index(2);
	var furnace = furnace_class.new().set_icon(load("res://tile/furnace.png")).set_index(14);
	
	match level:
		0:
			buildings[0][0] = conveyor_straight;
			buildings[1][0] = conveyor_straight;
			buildings[2][0] = conveyor_straight;
			
			locked[0][0] = true;
			locked[1][0] = true;
			locked[2][0] = true;
			
			inputs[0][0] = 1;
			inputs[2][0] = 1;
			inputs[0][2] = 0;
			inputs[2][2] = 0;
		1:
			inputs[0][3] = 0;
			inputs[4][0] = 0;
		2:
			buildings[0][0] = conveyor_straight;
			buildings[1][0] = conveyor_straight;
			buildings[2][0] = conveyor_straight;
			buildings[3][0] = conveyor_straight;
			buildings[4][0] = conveyor_straight;
			buildings[5][0] = conveyor_straight;
			buildings[0][2] = conveyor_straight;
			buildings[1][2] = conveyor_straight;
			buildings[2][2] = conveyor_straight;
			buildings[3][2] = conveyor_straight;
			buildings[4][2] = conveyor_straight;
			buildings[5][2] = conveyor_straight;
			
			inputs[0][0] = 1;
			inputs[5][0] = 1;
			inputs[0][2] = 0;
			inputs[5][2] = 0;
		3:
			buildings[2][1] = furnace;
			locked[2][1] = true;
			
			inputs[0][0] = 1;
			inputs[0][2] = 0;
			inputs[4][2] = 2;
		4:
			inputs[4][0] = 2;
		5:
			buildings[3][2] = furnace;
			locked[3][2] = true;
			
			inputs[1][1] = 7;
			inputs[0][4] = 6;
			inputs[6][0] = 1;
			inputs[5][3] = 0;
		6:
			inputs[0][1] = 4;
			inputs[5][0] = 4;
			inputs[5][2] = 4;
		7:
			inputs[0][0] = 4;
			inputs[0][2] = 4;
			inputs[5][1] = 4;
		8:
			buildings[2][1] = furnace;
			locked[2][1] = true;
			
			inputs[0][0] = 1;
			inputs[0][2] = 0;
			inputs[4][0] = 1;
			inputs[4][2] = 2;
		9:
			buildings[2][3] = furnace;
			locked[2][3] = true;
			
			inputs[0][0] = 4;
			inputs[0][2] = 4;
			inputs[0][4] = 3;
			inputs[4][0] = 5;
			inputs[4][4] = 5;
		10:
			buildings[5][1] = furnace;
			locked[5][1] = true;
			buildings[6][1] = conveyor_straight;
			locked[6][1] = true;
			
			buildings[5][3] = furnace;
			locked[5][3] = true;
			buildings[6][3] = conveyor_straight;
			locked[6][3] = true;
			
			inputs[1][0] = 4;
			inputs[0][3] = 8;
			inputs[1][4] = 8;
			inputs[6][1] = 5;
			inputs[6][3] = 3;
		11:
			buildings[3][2] = furnace;
			locked[3][2] = true;
			
			inputs[1][0] = 1;
			inputs[0][1] = 0;
			inputs[0][3] = 4;
			inputs[1][4] = 3;
			inputs[5][0] = 2;
			inputs[5][4] = 5;

static func populate_outputs(level, outputs):
	match level:
		0:
			outputs[2][2] = 12;
		1:
			outputs[4][0] = 12;
		2:
			outputs[5][0] = 12;
			outputs[5][2] = 12;
		3:
			outputs[4][2] = 12;
		4:
			outputs[4][0] = 6;
			outputs[4][2] = 6;
		5:
			outputs[6][0] = 12;
			outputs[5][3] = 12;
		6:
			outputs[5][0] = 6;
			outputs[5][2] = 6;
		7:
			outputs[5][1] = 12;
		8:
			outputs[4][0] = 6;
			outputs[4][2] = 6;
		9:
			outputs[4][0] = 6;
			outputs[4][4] = 6;
		10:
			outputs[6][1] = 12;
			outputs[6][3] = 12;
		11:
			outputs[5][0] = 12;
			outputs[5][4] = 12;

static func populate_toolbar(level, buildings):
	var conveyor_straight = conveyor_class.new().set_icon(load("res://tile/conveyor_straight/icon.png")).set_index(2);
	var conveyor_bent1 = conveyor_bent_class.new().set_icon(load("res://tile/conveyor_bent1/icon.png")).set_index(6);
	var conveyor_bent2 = conveyor_bent_class.new().set_icon(load("res://tile/conveyor_bent2/icon.png")).set_index(10).set_anticlockwise();
	var distributor = building_class.new().set_icon(load("res://tile/factory.png")).set_index(1);
	
	match level:
		0:
			buildings.append(conveyor_straight);
		1:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
		2:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
		3:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
		4:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
		5:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
		6:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
			buildings.append(distributor);
		7:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
			buildings.append(distributor);
		8:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
			buildings.append(distributor);
		9:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
			buildings.append(distributor);
		10:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
			buildings.append(distributor);
		11:
			buildings.append(conveyor_straight);
			buildings.append(conveyor_bent1);
			buildings.append(conveyor_bent2);
			buildings.append(distributor);

static func populate_briefing(level, array, number):
	var strings = [];
	match level:
		0:
			strings.append("Welcome employee #" + str(number) + ". My name is HAPI, and I have been assigned as your manager here at Iris Labs.");
			strings.append("Your job is to transfer the resources from the inputs to the outputs using the tools we have given you.");
			strings.append("Currently, you are only able to use the straight conveyor belt. It should be sufficient for this first task.");
			strings.append("Employee #" + str(number - 2) + " has already designed the top row, but it appears he quit before he finished the bottom row.");
		1:
			strings.append("This next task will require bent conveyor belts.");
			strings.append("I have added the clockwise and anticlockwise conveyor belts to your toolbar.");
		2:
			strings.append("This atrocious factory was just designed by employee #" + str(number - 1) + ", who was obviously fired on the spot.");
			strings.append("As you can see, this factory is highly inefficient. There is still a significant amount of empty space!");
			strings.append("I want you to redesign it, such that every tile has a purpose.");
		3:
			strings.append("This factory will make use of the furnace. It combines two inputs into one output.");
			strings.append("In this case, we want to make bronze from copper and tin.");
		4:
			strings.append("I'm sorry, but it appears the bronze contractor requested two belts of bronze, not one.");
		5:
			strings.append("One other use furnaces have is to smelt components, like wires, back into metal.");
			strings.append("Sadly, we could only afford one furnace.");
		6:
			strings.append("We have been asked to distribute coal to multiple destinations.");
			strings.append("This is a problem, since we only have one belt of coal to work with.");
			strings.append("Luckily, employee #" + str(number + 1) + " invented the distributor, which I have added to your toolbar.");
		7:
			strings.append("Apparently, the coal we sent was not up to their standards.");
			strings.append("They are sending both belts of coal back. I ask of you to make it one belt again.");
		8:
			strings.append("Our previous bronze contractor now also wants tin alongside his bronze.");
			strings.append("I do not have a factory vacant, since employee #" + str(number + 1) + " is using our newest factory, so we will return to a previous space.");
		9:
			strings.append("Speaking of contractors, we have received a letter telling us why the coal was returned.");
			strings.append("The contractor requested two belts of steel, not two belts of coal. As such, he sent the coal back.");
			strings.append("It is your responsibility to make sure this kind of mistake does not occur.");
			strings.append("The furnace is capable of smelting steel from coal and iron. Do not disappoint me again.");
		10:
			strings.append("Two belts of iron and steel have been requested from us.");
			strings.append("However, due to our heavy use of iron we currently have none.");
			strings.append("Not to worry, for we still have a large batch of iron wires we can smelt.");
			strings.append("I have also bought a second furnace, due to some complaints from employee #" + str(number + 1) + ".");
		11:
			strings.append("Our contractor now wants bronze alongside his steel, so I have added copper and tin as inputs.");
			strings.append("We had to sell the second furnace for more iron, but that won't be a problem, will it?");
	for i in range(0, strings.size()):
		array.append([]);
		for c in strings[i]:
			array[i].append(c);

static func populate_congratulations(level, array, number):
	var strings = [];
	match level:
		0: strings.append("Well done employee #" + str(number) + "! You're already doing better than employee #" + str(number - 2) + ".");
		1: strings.append("Congratulations, you have been promoted from junior factory designer to the only factory designer.");
		2: strings.append("Ah yes, this design is clearly superior to what employee #" + str(number - 1) + " cobbled together.");
		3: strings.append("As you are our only employee at the moment, you are now \"Employee of the Month\".");
		4: strings.append("I'm sorry to say your position as \"Employee of the Month\" is not guaranteed, as we have hired employee #" + str(number + 1) + ".");
		5: strings.append("But it appears only one furnace is enough for you, so I'll refrain from buying a second one for the time being.");
		6: strings.append("If you want to become \"Employee of the Month\", you should not be so reckless with our funds. Distributors are expensive, you know.");
		7: strings.append("You were " + str(randi() % 1900 + 100) + " milliseconds slower than employee #" + str(number + 1) + ". I would pick up the pace if I were you.");
		8: strings.append("A set of new factories has just been provided for you to destroy. I mean, to design.");
		9: strings.append("While you were fixing your previous error, employee #" + str(number + 1) + " has finished a task assigned to you, because he finished all of his.");
		10: strings.append("Remember when I said that you could become \"Employee of the Month\"? That was a lie. I had hoped your productivity would increase because of it.");
		11:
			strings.append("Employee #" + str(number + 1) + " is now \"Employee of the Month\". He thanks you for your uncompetitiveness.");
			strings.append("You have been fired.");
	for i in range(0, strings.size()):
		array.append([]);
		for c in strings[i]:
			array[i].append(c);

static func populate_failure(level, array, number):
	var strings = ["No no no, this won't do. There is still a significant amount of empty space!"];
	for i in range(0, strings.size()):
		array.append([]);
		for c in strings[i]:
			array[i].append(c);

static func populate_name(level, label):
	match level:
		0: label.set_text("Straight Ahead");
		1: label.set_text("Follow the Curve");
		2: label.set_text("Efficiency");
		3: label.set_text("Alloys");
		4: label.set_text("Split Alloys");
		5: label.set_text("Simultaneity");
		6: label.set_text("Coal Problems");
		7: label.set_text("Reversed Coal Problems");
		8: label.set_text("Split Paths");
		9: label.set_text("Your Mistake");
		10: label.set_text("Recycling");
		11: label.set_text("Trading");
