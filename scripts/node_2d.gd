extends Node2D

var cameraZoomCounter1 = 500
const cameraZoomNormal = Vector2(2, 2)
const cameraZoomZoom = Vector2(1, 1)


#--------------------------------------------------------------------


func _ready() -> void:
	$EndScreenBackground.visible = false
	
	$"Who won".visible = false
	$"Won how high?".visible = false
	$"Lost how high?".visible = false
	#$Camera2D.zoom = 2.21
			#2.21 --> 2560pxl x 1440pxl
			#x.xx --> 1080pxl x 720pxl


#-------------------------------------------------------------------


func _process(delta: float) -> void:
	#cameraZoom1()
	updateScoreboard()
	someonWon()
	
	#$"Player1/CameraZoom_Value".text = (str(cameraZoomCounter1))


#-------------------------------------------------------------------
#-------------------------------------------------------------------


#func cameraZoom1():
	#if cameraZoomCounter1 > 0:
		#if Input.is_action_pressed("cameraZoom1"):
			#$"Player1/Camera2D".zoom = cameraZoomZoom
			#cameraZoomCounter1 -= 1
			#print(cameraZoomCounter1)
		#else:
			#$"Player1/Camera2D".zoom = cameraZoomNormal
	#else:
		#$"Player1/Camera2D".zoom = cameraZoomNormal

#-------------------------------------------------------------------


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(1000)


#-------------------------------------------------------------------


func updateScoreboard():
	$Scoreboard_Player_1.text = (str(Global.score_player_1))
	$Scoreboard_Player_2.text = (str(Global.score_player_2))


#-------------------------------------------------------------------


func someonWon():
	if Global.score_player_1 == 10:
		$EndScreenBackground.visible = true
		$EndScreenBackground.color = "1dffff"
		$"Lost how high?".font_color = "ff0000"
		$"Lost how high?".text = (str(Global.score_player_2))
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
		
	elif Global.score_player_2 == 10:
		$EndScreenBackground.visible = true
		$EndScreenBackground.color = "ff0000"
		$"Lost how high?".font_color = "1dffff"
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
