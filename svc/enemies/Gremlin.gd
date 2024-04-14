extends CharacterBody2D

#constants
const damage = 1;

#variables
var target;
var root;
var speed = 200.0

var maxHealth = 2;
var health;

func _enter_tree():
	SignalController.find_player.emit(Callable(self, "target_player_if_closer"))
	health = maxHealth;
	SignalController.enemy_damage.connect(_on_hit)
	#Add some random variance for speed
	speed = speed * randf_range(0.75, 1.5)

func _ready():
	$Enemy.play("run")

func _process(_delta):
	if !target:
		SignalController.find_player.emit(Callable(self, "target_player_if_closer"))
		return

func _physics_process(_delta):
	if !is_instance_valid(target): #I hate that we have to do this
		return
	#look at player
	if target:
		look_at(target.global_position)
	
	#move towards player
	velocity = speed * global_position.direction_to(target.global_position)
	move_and_slide()

#Functions

func target_player_if_closer(player):
	if !target:
		target = player
		return
	if self.global_position.distance_to(player.global_position) < self.global_position.distance_to(target.global_position):
		target = player

func generate_Loot():
	if GlobalVariables.materials.has('GremlinMats'):
		GlobalVariables.materials['GremlinMats'] +=1
		return
	GlobalVariables.materials['GremlinMats'] =1

#Events

func _on_hurtbox_body_entered(body):
	if body.is_in_group("Player"):
		SignalController.player_damage.emit(damage)

func _on_hit(enemy, Damage):
	#Ignore if not relating to us
	if enemy != self:
		return
	health -= Damage
	if health <= 0:
		generate_Loot()
		queue_free() #kill
