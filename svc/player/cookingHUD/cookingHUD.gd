extends CanvasLayer

#Export Variables


#variables
var minutes
var seconds

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	SignalController.oven_start.connect(_on_cooking_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_mat_text()
	var timerInfo = int(ceil(GlobalVariables.timeLeft))
	seconds = timerInfo % 60
	timerInfo -= seconds
	minutes = timerInfo / 60
	$Timer.text = str(minutes, ":", seconds)

func update_mat_text():
	$Money.text = str("Money: $", 
		GlobalVariables.money if GlobalVariables.money else 0)
	
	$GremlinLabel.text = str("Raw Gremlins: ",
		GlobalVariables.materials["GremlinMats"] if GlobalVariables.materials.has("GremlinMats") else 0)

#Events

func _on_cooking_start(lootCost):
	update_mat_text()
