extends Node

#Player
signal player_damage(damage)
signal player_health_change(health, maxhealth)
signal interact(target, value)
signal highlight(target, truefalse)
signal remove_interaction(target)
signal try_pickup(target)

#Enemy
signal enemy_damage(enemy, damage)

#UI
signal timer_update(seconds)

#cooking
signal oven_start(lootCost) #unimplemented
signal diable_ovens()
signal complete_order(target, order)
signal remove_table(happyCustomer)

#Item payloads
signal try_place(target)
signal try_grab(grabber, target)
signal accept_order(target)

