extends CharacterBody2D

#Constants


#Exports
@export var health = 3;
@export var maxHealth = 3;
@export var speed = 250;
@export var Bullet : PackedScene

#Player Stats
var iFrameMax = 1;
var tempHealth = 2; #unimplemented
var shootCooldownMax = 0.25
var shootCooldown = 0

#Player States
var iFrames = 0;
var invincible = false;
var shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.player_damage.connect(_on_hit)
	SignalController.find_player.connect(_on_find_player)
	SignalController.player_health_change.emit(health,maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	iFrames -= delta;
	shootCooldown -= delta
	if shooting and !(shootCooldown > 0):
		shoot()

func _physics_process(_delta):
	var input_direction = Input.get_vector("control_left", "control_right", "control_up", "control_down")
	velocity = input_direction * speed
	move_and_slide()
	$Muzzle.look_at(get_global_mouse_position())

#Functions

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle/Tip.global_transform
	shootCooldown = shootCooldownMax

#Events

func _input(event):
	if event.is_action_pressed("shoot"):
		shooting = true
	if event.is_action_released("shoot"):
		shooting = false

func _on_hit(damage = 1):
	if invincible or iFrames > 0:
		return #do nothing if im invincible or have iFrames
	
	#Health Change
	health -= damage;
	SignalController.player_health_change.emit(health, maxHealth)
	
	#Set iFrames
	iFrames = iFrameMax
	
	#Did player die?
	if health <= 0:
		SignalController.player_die.emit()
		queue_free()

func _on_find_player(function:Callable):
	function.call(self)
