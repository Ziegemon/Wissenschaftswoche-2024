extends Node2D

var lavaON = true             #extra difficulty --> true/false
var lavaRisngSpeed = 0.0005   #balanced --> 0.0005
var lavaRisingCounter = 1     #--> 1


#---------------------------------------------------------------------

func _ready() -> void:
	pass


#--------------------------------------------------------------------


func _process(delta: float) -> void:

	lavaRising()


#--------------------------------------------------------------------
#--------------------------------------------------------------------


func lavaRising():
	
	if lavaON == true:
		if $TileMap.position.y >0:
			if lavaRisingCounter < 10:
				$TileMap.position.y = $TileMap.position.y - (lavaRisngSpeed * lavaRisingCounter)
				lavaRisingCounter += 0.001
				print("-----------------------------------")
				print("lavaRisingCounter: ", lavaRisingCounter)
				print("lavaRisingSpeed: ", lavaRisngSpeed * lavaRisingCounter)
				print("Tilemap Position: ", $TileMap.position.y)
				print("-----------------------------------")
			else:
				$TileMap.position.y -= 0.005
				print("-----------------------------------")
				print("Tilemap Position: ", $TileMap.position.y)
				print("-----------------------------------")

#ganz viel test
