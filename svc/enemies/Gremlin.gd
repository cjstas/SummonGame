extends CharacterBody2D

#constants
const speed = 150.0
const damage = 1;

#variables
var target;
var root;

var maxHealth = 2;
var health;

func _enter_tree():
	target_closest_player()
	health = maxHealth;
	SignalController.enemy_damage.connect(_on_hit)
	

func _physics_process(delta):
	if !target:
		#target_closest_player()
		return
	#look at player
	look_at(target.global_position)
	
	#move towards player
	velocity = speed * global_position.direction_to(target.global_position)
	move_and_slide()

#Functions

func target_closest_player():
	var closestDistance = INF
	var closestChild;
	
	for child in get_parent().get_children():
		if child.is_in_group("Player"):
			var distance = self.global_position.distance_to(child.global_position)
			if distance < closestDistance:
					closestChild = child
					closestDistance = distance
	
	target = closestChild

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
