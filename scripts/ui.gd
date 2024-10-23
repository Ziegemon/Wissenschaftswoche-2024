extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar_player_1.value = Global.health_player_1
	$HealthBar_player_2.value = Global.health_player_1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateHealthBars()


func updateHealthBars():
	$HealthBar_player_1.value = Global.health_player_1
	$HealthBar_player_2.value = Global.health_player_2
