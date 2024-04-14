extends CharacterBody2D

#variables
var currentOrder

func _ready():
	#Generate an order when spawned. Order should always be possible based on other orders and resources available
	SignalController.complete_order.connect(_on_order_recieved)
	generate_order()

func _physics_process(_delta):
	pass

func generate_order():
	#Make a copy of the dictionary
	currentOrder = GlobalVariables.recipes.keys()[randi() % GlobalVariables.recipes.keys().size()]
	register_order()

func register_order():	
	if GlobalVariables.dishImages.has(currentOrder):
		$ThoughtCloud/Dish.set_texture(GlobalVariables.dishImages[currentOrder])

func order_complete():
	#emit a signal to destroy the table (the meal should be destroyed too)
	GlobalVariables.money += 1
	SignalController.remove_table.emit(self)

func _on_order_recieved(target, order):
	if target == self and currentOrder == order.dishName:
		order_complete()
