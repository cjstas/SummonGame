extends CharacterBody2D

#variables
var currentOrder

func _ready():
	#Generate an order when spawned. Order should always be possible based on other orders and resources available
	SignalController.complete_order.connect(_on_order_recieved)
	generate_order()

func _physics_process(delta):
	pass

func generate_order():
	#Make a copy of the dictionary
	var activeOrders = GlobalVariables.currentOrders
	var menu = GlobalVariables.recipes
	var order;
	
	while menu.keys().size() > 0:
		#grab a random menu item
		var randomKey = menu.keys()[randi() % menu.keys().size()]
		order = randomKey
		var ingredients = menu[randomKey]
		var numberOfOrders = (activeOrders[randomKey] if activeOrders.has(randomKey) else 0)
		#If it can't be fufilled, grab another random key until we run out
		for ingredient in ingredients.keys():
			var number = ingredients[ingredient]
			if !((GlobalVariables.materials[ingredient] if GlobalVariables.materials.has(ingredient) else 0)
			 > (number * (numberOfOrders))):
				#We don't have the supplies to fufill this order
				order = null;
		if !order:
			menu.erase(randomKey)
			continue
		break
	
	#if an order does not exist, then there is no point in living
	if !order:
		SignalController.remove_table.emit(self)
		#this is where a signal might go to tell dudes to stop spawning
	currentOrder = order
	register_order()

func register_order():
	if GlobalVariables.currentOrders.has(currentOrder):
		GlobalVariables.currentOrders[currentOrder] +=1
	else:
		GlobalVariables.currentOrders[currentOrder] =1
	
	if GlobalVariables.dishImages.has(currentOrder):
		$ThoughtCloud/Dish.set_texture(GlobalVariables.dishImages[currentOrder])

func order_complete():
	#emit a signal to destroy the table (the meal should be destroyed too)
	GlobalVariables.money += 1
	SignalController.remove_table.emit(self)


func _on_order_recieved(target, order):
	if target == self and currentOrder == order.dishName:
		order_complete()
