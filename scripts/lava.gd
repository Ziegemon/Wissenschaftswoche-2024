extends Node2D



#--------------------------------------------------------------------

func _ready() -> void:
	pass


#--------------------------------------------------------------------


func _process(delta: float) -> void:
	lavaRising()


#--------------------------------------------------------------------
#--------------------------------------------------------------------


func lavaRising():
	
	if Global.lavaON == true:
		if $TileMap.position.y >0:
			if Global.lavaRisingCounter < 10:
				$TileMap.position.y = $TileMap.position.y - (Global.lavaRisngSpeed * Global.lavaRisingCounter)
				Global.lavaRisingCounter += 0.001
				print(" -----------------------------------")
				print("lavaRisingCounter: ", Global.lavaRisingCounter)
				print("lavaRisingSpeed: ", Global.lavaRisngSpeed * Global.lavaRisingCounter)
				print("Lava Position: ", $TileMap.position.y)
				print(" -----------------------------------")
			else:
				$TileMap.position.y -= 0.005
				print(" -----------------------------------")
				print("lavaRisingCounter: ", Global.lavaRisingCounter)
				print("lavaRisingSpeed: ", Global.lavaRisngSpeed * Global.lavaRisingCounter)
				print("Lava Position: ", $TileMap.position.y)
				print(" -----------------------------------")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(1000)
	
	
