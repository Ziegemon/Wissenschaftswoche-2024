extends Node

var score_player_1 = 0
var score_player_2 = 9

var health_player_1 = 100
var health_player_2 = 100

var lavaON = true                #extra difficulty --> true/false
var lavaRisngSpeed = 0.012       #balanced --> 0.012
var lavaRisingCounter = 1.15     #--> 1.15
var lavaAtCerteinHeight = false

var game_paused = false
var player_died = false

var lavaHeight = 700

var triggerEndgame = false

var resetEndscreen = false

var resetStage_1 = false
var resetStage_2 = false
var resetStage_3 = false
var resetStage_4 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
