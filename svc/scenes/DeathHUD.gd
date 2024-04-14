extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.player_die.connect(_on_player_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_die():
	_on_score_ready()
	_on_gremlins_ready()
	_on_money_ready()
	visible = true

func _on_quit_button_pressed():
	get_tree().quit()


func _on_money_ready():
	$PanelContainer/VBoxContainer/GridContainer/Money.text = str(GlobalVariables.money)


func _on_gremlins_ready():
	var gremlinsKilled
	var gremlinMaterials = GlobalVariables.materials["GremlinMats"] if GlobalVariables.materials.has("GremlinMats") else 0
	gremlinsKilled = gremlinMaterials + (5 * GlobalVariables.money)
	$PanelContainer/VBoxContainer/GridContainer/Gremlins.text = str(gremlinsKilled)


func _on_score_ready():
	var gremlinMaterials = GlobalVariables.materials["GremlinMats"] if GlobalVariables.materials.has("GremlinMats") else 0
	var gremlinsKilled = gremlinMaterials + (5 * GlobalVariables.money)
	
	var score = (GlobalVariables.money * 10) + gremlinsKilled
	$PanelContainer/VBoxContainer/GridContainer/Score.text = str(score)
