extends Node

var score_player_1 = 0
var score_player_2 = 0

var health_player_1 = 100
var health_player_2 = 100

var lavaON = true             #extra difficulty --> true/false
var lavaRisngSpeed = 0.0005   #balanced --> 0.0005
var lavaRisingCounter = 1     #--> 1

var winner_player_1 = false
var winner_player_2 = false

var game_paused = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
