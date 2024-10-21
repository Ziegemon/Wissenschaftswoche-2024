extends Node2D

var cameraZoomCounter1 = 500
const cameraZoomNormal = Vector2(2, 2)
const cameraZoomZoom = Vector2(1, 1)

var score_player_1 = 0
var score_player_2 = 0

#--------------------------------------------------------------------

func _ready() -> void:

	$Camera2D.zoom = 2.21
			#2.21 --> 2560pxl x 1440pxl
			#x.xx --> 1080pxl x 720pxl
			
#-------------------------------------------------------------------

func _process(delta: float) -> void:
	cameraZoom1()
	
	#$"Player1/CameraZoom_Value".text = (str(cameraZoomCounter1))

#-------------------------------------------------------------------
#-------------------------------------------------------------------

func cameraZoom1():
	if cameraZoomCounter1 > 0:
		if Input.is_action_pressed("cameraZoom1"):
			$"Player1/Camera2D".zoom = cameraZoomZoom
			cameraZoomCounter1 -= 1
			print(cameraZoomCounter1)
		else:
			$"Player1/Camera2D".zoom = cameraZoomNormal
	else:
		$"Player1/Camera2D".zoom = cameraZoomNormal

#-------------------------------------------------------------------


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(1000)


#-------------------------------------------------------------------


func updateScoreboard():
	if $player_1.alive == false:
		score_player_2 +=1
		
	if $player_2.alive == false:
		score_player_1 +=1
		
	$Scoreboard_Player_1.text = (str(score_player_1))
	$Scoreboard_Player_2.text = (str(score_player_2))
