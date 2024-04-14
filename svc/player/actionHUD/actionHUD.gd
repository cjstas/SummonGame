extends CanvasLayer

#Export Variables
@export var filledHeart : PackedScene
@export var emptyHeart : PackedScene

#variables
var minutes
var seconds

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	SignalController.player_health_change.connect(_on_player_health_change)
	SignalController.player_damage.emit(0) #emit a 0 damage pulse to get a health update


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_mat_text()
	var timerInfo = int(ceil(GlobalVariables.timeLeft))
	seconds = timerInfo % 60
	timerInfo -= seconds
	minutes = timerInfo / 60
	$Timer.text = str(minutes, ":", seconds)

func update_mat_text():
	$GremlinLabel.text = str("Raw Gremlins: ",
		GlobalVariables.materials["GremlinMats"] if GlobalVariables.materials.has("GremlinMats") else 0)

#Events

func _on_player_health_change(health, maxHealth):
	#remove existing children
	for child in $Grid.get_children():
		$Grid.remove_child(child)
	
	#Re-populate it up
	var iterator = 0
	var healthIterator = health
	var maxHealthIterator = maxHealth
	while iterator != maxHealth:
		maxHealthIterator -=1
		
		#if there is still full health, display that and continue
		if healthIterator > 0:
			var heart = filledHeart.instantiate()
			$Grid.add_child(heart)
			healthIterator -=1
		else:
			var heart = emptyHeart.instantiate()
			$Grid.add_child(heart)
		iterator +=1
