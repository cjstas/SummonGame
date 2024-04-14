extends Area2D

var dishName = "GremlinRoast"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interactable")
	SignalController.interact.connect(_on_interaction)
	SignalController.highlight.connect(_on_highlight)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Events

func _on_interaction(target, value):
	if target == self:
		SignalController.try_pickup.emit(self)

func _on_highlight(target, highlighted):
	if target==self:
		GlobalVariables.highlight(target, highlighted, $Sprite)
