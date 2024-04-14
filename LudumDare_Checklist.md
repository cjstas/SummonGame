Ludum Dare Plan

~~Phase 1 The Basics~~
	Action Section
	 [x] Basic Action Controls [moving, shooting]
	 [x] Basic Action enemy [walk towards player & collides]
	 [x] Bullet kills enemy [instant death]
	 [x] Enemy hurts player [health, collision interaction, i-frames]
	 [x] Summon Portal [summon enemies from portal]
	 [x] Bullet hurts enemy [replace instant death with health system]
	 [x] Health Bar
	 [x] Kill Count
	 [x] Timer before entering non-action section

	Non Action Section
	 [x] Basic Action Controls [moving, interacting]
	 [x] Cooking Machine [Interact consumes resource and then cooks for a bit, then spits out a finished meal]
	 [x] Player may only carry one finished meal at a time
	 [x] Customer fills table slots [customer, no animation, just have them appear]
		[x] Changed idea - Tables will randomly spawn around a sigil in the room similar to enemies
	 [x] Customer request meal [single meal from single resource]
	 [x] Resource gained from killing monster
	 [x] Money resource gained from serving customers [Money can serve as a Score for a 'finished' game
	 [x] Fix bug with timer at the top

~~Phase 1 completed. A 'game' has been created~~

Notes for improvements
 [ ] enemies should spawn in random locations
	[ ] in order for this to feel fair, a summon indicator needs to be created in advance to show where they are spawning
 [ ] variance in enemy speed to make some more threatening
 [ ] graphic and proper hitbox for player
	[ ] visual indicators for hurt, iframes, etc
 [ ] graphic and proper hitbox for enemy
 [ ] limit on player shoot ability (cooldown)
 
 [ ] Dodge system
	[ ] Start position + angle + time = animation lock
		[ ] Should be able to utilize the iFrame system or the invincibility system easily for this
 [ ] portal should be disabled at the start along with the timer. upon interacting or shooting the portal, it will activate and kick off the timer
 [ ] transition scene (fade in & fade out) for scene transitions so that its not so jarring


~~Phase 2 Finishing the Features~~

	Action Section
	 [ ] Add 2 more enemy types
		[ ] Add a shooting enemy
		[ ] Add an enemy with a charge or melee ranged attack
	 [ ] Add a boss
		[ ] Have lots of health
		[ ] Shoot at the player sometimes
		[ ] Hit the player sometimes
		[ ] Summon more guys
	 [ ] Add definitions for the rounds for this (increasing difficulty)
		 [ ] Have a 'difficulty value that increases exponentially and controls how many and what enemies spawn

	Non Action Section
	 [ ] 3 More resources
		[ ] One for each enemy added in the Action Section
	 [ ] 3 more dishes
		[ ] One for each resource type added
	 [ ] Variance in pricing and requested dish from customers
	 [ ] Upgrades??

~~Phase 2 completed. This is starting to feel like a game ~~
~~Phase 3 Game Polish~~

	Action Section
	 [ ] surround environment outside of room

	Non Action Section
	 [ ] surround environment outside of room
	 
~~Phase 3 completed. This looks and feels like a game ~~

