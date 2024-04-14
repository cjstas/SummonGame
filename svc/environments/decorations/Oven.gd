extends Area2D

#Exports
@export var gremlinRoast : PackedScene
@export var recipeName : String = "GremlinRoast"

#variables
var cooking = false;
var timerMultiplier = 1 #lower = better
var defaultTimer = 3

var dishInOven

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interactable")
	SignalController.interact.connect(_on_interaction)
	SignalController.highlight.connect(_on_highlight)
	SignalController.diable_ovens.connect(make_uninteractable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Update timer time
	$Countdown.text = str(ceil($Timer.get_time_left()))

#functions

func make_uninteractable():
	if !dishInOven:
		remove_from_group("Interactable")
		set_collision_mask_value(3, false)

func make_interactable():
	add_to_group("Interactable")
	set_collision_mask_value(3, true)

func claim_ownership():
	dishInOven.remove_from_group("Interactable")
	dishInOven.reparent(self)
	dishInOven.global_transform = $DishSpot.global_transform

func release_ownership():
	dishInOven.add_to_group("Interactable")
	dishInOven.reparent(owner)
	dishInOven.global_transform = $DishSpot.global_transform
	dishInOven = null
	if GlobalVariables.materials["GremlinMats"] <= 0:
		make_uninteractable()

#Events

func _on_interaction(target, value):
	if target == self and !cooking:
		#if value has a payload and there is already a dish, do nothing
		if value and dishInOven:
			return
		#if there is a dish and no payload, then tell the player to pick it up
		elif dishInOven:
			var tempDish = dishInOven
			release_ownership()
			SignalController.try_pickup.emit(tempDish)
			return
		
		
		#else, start cooking if we can
		var recipe = GlobalVariables.recipes[recipeName]
		for key in recipe.keys():
			var mats = GlobalVariables.materials[key] if GlobalVariables.materials.has(key) else 0
			var matcost = GlobalVariables.recipes[recipeName][key]
			if mats < matcost:
				return #uncookable
		#cookable recipe, so remove the materials and then cook it. bad solution, but a solution
		for key in recipe.keys():
			var matcost = GlobalVariables.recipes[recipeName][key]
			GlobalVariables.materials[key] -= matcost
		#cook it
		#Stop interaction and set the timer time
		make_uninteractable()
		_on_highlight(self, false)
		$Timer.start(defaultTimer)
		$Sprite.set_frame(1)
		cooking = true



func _on_timer_timeout():
	$Sprite.set_frame(0)
	var dish = gremlinRoast.instantiate()
	dishInOven = dish
	owner.add_child(dish)
	claim_ownership()
	make_interactable()
	#Dont make it interactable if we don't have the mats to cook
	cooking = false
	$Timer.stop()

func _on_highlight(target, highlighted):
	if target==self:
		GlobalVariables.highlight(target, highlighted, $Sprite)
