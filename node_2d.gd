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
	
	$Restart.visible = false
	
	#$Camera2D.zoom = 2.2
			#2.21 --> 2560pxl x 1440pxl
			#1.65 --> Schul-PCs


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
		$EndScreenBackground.color = "00a0a0"
		$"Lost how high?".modulate = Color(1, 0, 0)
		$"Lost how high?".text = (str(Global.score_player_2))
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
		$"End Match".visible = false
		await get_tree().create_timer(1.5).timeout
		$Restart.visible = true
		$"End Match".visible = false

	elif Global.score_player_2 == 10:
		$EndScreenBackground.visible = true
		$EndScreenBackground.color = "940000"
		$"Lost how high?".modulate = Color(29, 255, 255)
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
		$"End Match".visible = false
		await get_tree().create_timer(1.5).timeout
		$Restart.visible = true
		$"End Match".visible = false



func _on_restart_pressed() -> void:
	var health_player_1 = 100
	var health_player_2 = 100
	Engine.time_scale = 1
	Global.score_player_1 = 0
	Global.score_player_2 = 0
	$"Who won".visible = false
	$"Won how high?".visible = false
	$"Lost how high?".visible = false
	$Restart.visible = false
	$"End Match".visible = true
	get_tree().reload_current_scene()
