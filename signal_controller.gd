extends Node

#World
signal activate_portal()
signal deactivate_portal()
signal kill_all_customers()

#Player
signal player_damage(damage)
signal player_health_change(health, maxhealth)
signal interact(target, value)
signal banish(target)
signal highlight(target, truefalse)
signal remove_interaction(target)
signal try_pickup(target)
signal player_die()

#Enemy
signal enemy_damage(enemy, damage)
signal find_player(function)
signal parent_enemy(enemy)

#UI
signal timer_update(seconds)

#cooking
signal oven_start(lootCost) #unimplemented
signal diable_ovens()
signal complete_order(target, order)
signal remove_table(happyCustomer)
signal banish_table(table)

#Item payloads
signal try_place(target)
signal try_grab(grabber, target)
signal accept_order(target)

