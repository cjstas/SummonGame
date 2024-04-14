extends Node

#misc
var difficultFactor = 1 #unimplemented

#resources
var Highlight = preload("res://assets/shaders/highlight.tres")
var dishImages = { #string order name, string path to associated asset
	"GremlinRoast" : preload("res://assets/dishes/GremlinRoast.png")
} 

#Resources
var money = 0

#Orders
var recipes = {} #string order name, dictonary {string material, int number}
var materials = {} #material name, current number of this material

#Timer
var timeLeft = 0


#global functions
func highlight(_target, highlighted, sprite):
	if highlighted:
		sprite.material = Highlight
		return
	sprite.material = null


#Debug items
func _ready():
	recipes["GremlinRoast"] = {"GremlinMats": 5}
