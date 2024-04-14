extends CanvasLayer

#Export Variables


#variables
var minutes
var seconds

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	SignalController.oven_start.connect(_on_cooking_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_mat_text()

func update_mat_text():
	$Money.text = str("Money: $", 
		GlobalVariables.money if GlobalVariables.money else 0)
	
	$GremlinLabel.text = str("Raw Gremlins: ",
		GlobalVariables.materials["GremlinMats"] if GlobalVariables.materials.has("GremlinMats") else 0)

#Events

func _on_cooking_start(_lootCost):
	update_mat_text()
