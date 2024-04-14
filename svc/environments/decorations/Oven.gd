extends Area2D

#Exports
@export var gremlinRoast : PackedScene

#variables
var cooking = false;
var timerMultiplier = 1 #lower = better
var defaultTimer = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interactable")
	SignalController.interact.connect(_on_interaction)
	SignalController.highlight.connect(_on_highlight)
	SignalController.diable_ovens.connect(make_uninteractable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Update timer time
	$Countdown.text = str(ceil($Timer.get_time_left()))

#functions

func make_uninteractable():
	remove_from_group("Interactable")
	set_collision_mask_value(3, false)

func make_interactable():
	add_to_group("Interactable")
	set_collision_mask_value(3, true)

#Events

func _on_interaction(target, value):
	if target == self and !cooking:
		if GlobalVariables.materials.has("GremlinMats") and GlobalVariables.materials["GremlinMats"] > 0:
			#Stop interaction and set the timer time
			make_uninteractable()
			_on_highlight(self, false)
			$Timer.start(defaultTimer)
			$Sprite.set_frame(1)
			cooking = true
			GlobalVariables.materials["GremlinMats"] -=1
			if GlobalVariables.materials["GremlinMats"] <= 0:
				SignalController.diable_ovens.emit()



func _on_timer_timeout():
	$Sprite.set_frame(0)
	var dish = gremlinRoast.instantiate()
	owner.add_child(dish)
	dish.transform = $DishSpawn.global_transform
	#Dont make it interactable if we don't have the mats to cook
	if GlobalVariables.materials["GremlinMats"] > 0:
		make_interactable()
	cooking = false
	$Timer.stop()

func _on_highlight(target, highlighted):
	if target==self:
		GlobalVariables.highlight(target, highlighted, $Sprite)
