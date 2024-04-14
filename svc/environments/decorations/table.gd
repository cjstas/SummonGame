extends Area2D

@export var customerScene : PackedScene

var customer
var side
var spawnLocation

var dishOnTable

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interactable")
	add_to_group("HeldInteractable")
	add_to_group("Banishable")
	#listeners
	SignalController.try_grab.connect(_on_order_recieved)
	SignalController.interact.connect(_on_interact)
	SignalController.highlight.connect(_on_highlight)
	SignalController.remove_table.connect(_on_order_accepted)
	SignalController.kill_all_customers.connect(_on_die)
	SignalController.banish.connect(_on_banish)
	#Pick which side to set us on (currently only left because thats the only customer i made)
	side = "Left"
	
	#Delete the non-seated side's chair
	if side == "Left":
		$Chair_Right.queue_free()
		spawnLocation = $Chair_Left/Left_spawn
	elif side=="Right":
		$Chair_Left.queue_free()
		spawnLocation = $Chair_Right/Right_spawn
	
	#Create a customer and attach them to the chair
	customer = customerScene.instantiate()
	add_child(customer)
	customer.transform = spawnLocation.transform

func _enter_tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#functions
func claim_ownership():
	dishOnTable.remove_from_group("Interactable")
	dishOnTable.reparent(self)
	dishOnTable.global_transform = $DishSpot.global_transform

func release_ownership():
	dishOnTable.add_to_group("Interactable")
	dishOnTable.reparent(owner)
	dishOnTable.global_transform = $DishSpot.global_transform
	dishOnTable = null



#events

func _on_interact(target, value):
	if target == self:
		#if value has a payload, emit a signal telling the player to drop the dish and commuicate back when its done
		if value and !dishOnTable:
			SignalController.try_place.emit(self)
			return
		
		#if there is already a dish, then the player can try to pick it up i guess
		if dishOnTable:
			var tempDish = dishOnTable
			release_ownership()
			SignalController.try_pickup.emit(tempDish)

func _on_order_recieved(grabber, target):
	#Communicate to the customer sitting at the table that the order must be evaluated
	if grabber == self and target:
		dishOnTable = target
		claim_ownership()
		SignalController.complete_order.emit(customer, dishOnTable)

func _on_order_accepted(target):
	if target == customer:
		customer.queue_free()
		_on_die()

func _on_highlight(target, highlighted):
	if target==self:
		GlobalVariables.highlight(target, highlighted, $Table)

func _on_banish(target):
	if target == self:
		_on_die()

func _on_die():
	SignalController.banish_table.emit()
	queue_free()
