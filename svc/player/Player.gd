extends CharacterBody2D

#Constants


#Exports
@export var health = 10;
@export var maxHealth = 10;
@export var speed = 200;
@export var Bullet : PackedScene

#Player Stats
var iFrameMax = 1;
var tempHealth = 2; #unimplemented

#Player States
var iFrames = 0;
var invincible = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.player_damage.connect(_on_hit)
	SignalController.player_health_change.emit(health,maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	iFrames -= delta;

func _physics_process(delta):
	var input_direction = Input.get_vector("control_left", "control_right", "control_up", "control_down")
	velocity = input_direction * speed
	move_and_slide()
	look_at(get_global_mouse_position())

#Functions

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform

#Events

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()

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
		queue_free() #die???
	
