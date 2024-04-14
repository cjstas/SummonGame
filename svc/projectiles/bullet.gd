extends Area2D

#export variables
@export var speed = 400;

#variables
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("Enemy"):
		SignalController.enemy_damage.emit(body, damage)
	queue_free()
