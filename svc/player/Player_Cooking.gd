extends CharacterBody2D

#Constants


#Exports
@export var speed = 250;

#Player Stats

#Player States
var canInteract = true

#Interaction Stuff
var interactablesInRange = [];
var currentlyQueued;

var heldItem;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.try_pickup.connect(_on_pickup)
	SignalController.try_place.connect(_on_place)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if canInteract:
		find_closest_interactable()
		SignalController.highlight.emit(currentlyQueued, true)

func _physics_process(_delta):
	var input_direction = Input.get_vector("control_left", "control_right", "control_up", "control_down")
	velocity = input_direction * speed
	move_and_slide()
	$Muzzle.look_at(get_global_mouse_position())

#Functions

func interact():
	if heldItem and !(currentlyQueued.is_in_group("HeldInteractable") if currentlyQueued else false):
		_on_drop()
		return
	SignalController.interact.emit(currentlyQueued, heldItem)
	SignalController.highlight.emit(currentlyQueued, false)
	interactablesInRange.erase(currentlyQueued)
	currentlyQueued = null

func banish():
	if (currentlyQueued.is_in_group("Banishable") if currentlyQueued else false):
		SignalController.banish.emit(currentlyQueued)


func find_closest_interactable():
	var closestInteractable
	var closestDistance = INF
	for interactable in interactablesInRange:
		if !is_instance_valid(interactable) :
			#If the interactable no longer exists, remove it and contine
			interactablesInRange.erase(interactable)
			continue
		var distance = get_global_mouse_position().distance_to(interactable.global_position)
		if  distance < closestDistance:
			closestInteractable = interactable
			closestDistance = distance
	if currentlyQueued != closestInteractable:
		SignalController.highlight.emit(currentlyQueued, false)
	currentlyQueued = closestInteractable

#Events

func _on_pickup(target: Area2D):
	if !heldItem and target:
		target.remove_from_group("Interactable")
		target.reparent($Muzzle/Tip)
		target.position = $Muzzle/Tip.position
		heldItem = target

func _on_drop():
	if heldItem:
		heldItem.reparent(owner)
		heldItem.add_to_group("Interactable") #could cause bugs later if i add fancier interactables
		heldItem.global_position = $Muzzle/Tip.global_position
		heldItem = null

func _on_place(target):
	#get a local reference to the object and drop it
	var item = heldItem
	_on_drop()
	#Communicate that the source should try to pick it up and what it is
	SignalController.try_grab.emit(target, item)
	

func _input(event):
	if event.is_action_pressed("interact"):
		interact()
	if event.is_action_pressed("banish"):
		banish()


func _on_interaction_radius_area_entered(area):
	if area.is_in_group("Interactable"):
		interactablesInRange.append(area)
		#print(area.name)


func _on_interaction_radius_area_exited(area):
	interactablesInRange.erase(area)
