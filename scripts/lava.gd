extends Node2D

#--------------------------------------------------------------------

func _ready() -> void:
	pass


#--------------------------------------------------------------------


func _process(delta: float) -> void:
	lavaRising()
	SendCords()


#--------------------------------------------------------------------
#--------------------------------------------------------------------


func lavaRising():
	if Global.game_paused == true:
		if Global.lavaON == true:
			if Global.lavaRisingCounter <3:
				$TileMap.position.y = $TileMap.position.y - (Global.lavaRisngSpeed * Global.lavaRisingCounter)
				Global.lavaRisingCounter += 0.001
				print(" -----------------------------------")
				print("lavaRisingCounter: ", Global.lavaRisingCounter)
				print("lavaRisingSpeed: ", Global.lavaRisngSpeed * Global.lavaRisingCounter)
				print("Lava Position: ", $TileMap.position.y)
				print(" -----------------------------------")
			else:
				$TileMap.position.y -= 0.036
				print(" -----------------------------------")
				print("lavaRisingCounter: ", Global.lavaRisingCounter)
				print("lavaRisingSpeed: ", Global.lavaRisngSpeed * Global.lavaRisingCounter)
				print("Lava Position: ", $TileMap.position.y)
				print(" -----------------------------------")
		
		if $TileMap.position.y <= 575:
			Global.lavaAtCerteinHeight = true

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(1000)


func SendCords():
	Global.lavaHeight = $TileMap.position.y
