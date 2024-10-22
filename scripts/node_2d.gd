extends Node2D

var cameraZoomCounter1 = 500
const cameraZoomNormal = Vector2(2, 2)
const cameraZoomZoom = Vector2(1, 1)

var sound_celebration = preload("res://sounds/celebration.mp3")

var init_pos_player_1 = Vector2()
var init_pos_player_2 = Vector2()


#--------------------------------------------------------------------


func _ready() -> void:
	$EndScreenBackground.visible = false
	
	$"Who won".visible = false
	$"Won how high?".visible = false
	$"Lost how high?".visible = false
	
	$Restart.visible = false
	
	init_pos_player_1 = $player_1.position
	init_pos_player_2 = $player_2.position
	
	
	#$Camera2D.zoom = 2.2
			#2.21 --> 2560pxl x 1440pxl
			#1.65 --> Schul-PCs


#-------------------------------------------------------------------


func _process(delta: float) -> void:
	#cameraZoom1()
	updateScoreboard()
	someoneWon3()
	
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
		$Music.stream = sound_celebration
		$Music.play()
		$EndScreenBackground.visible = true
		$EndScreenBackground.color = "00a0a0"
		$"Lost how high?".modulate = Color(1, 0, 0)
		$"Lost how high?".text = (str(Global.score_player_2))
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
		$"End Match".visible = false
		Global.health_player_1 = 100
		Global.health_player_2 = 100
		await get_tree().create_timer(2.5).timeout
		$Restart.visible = true
		#$"End Match".visible = false
		

	elif Global.score_player_2 == 10:
		$Music.stream = sound_celebration
		$Music.play()
		$EndScreenBackground.visible = true
		$EndScreenBackground.color = "940000"
		$"Lost how high?".modulate = Color(29, 255, 255)
		$"Lost how high?".text = (str(Global.score_player_1))
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
		$"End Match".visible = false
		Global.health_player_1 = 100
		Global.health_player_2 = 100
		await get_tree().create_timer(2.5).timeout
		$Restart.visible = true
		#$"End Match".visible = false


#-------------------------------------------------------------------



func someoneWon2():
	if Global.health_player_1 <= 0 || Global.health_player_2 <= 0:
		
		if Global.health_player_1 <= 0:
			Global.score_player_2 += 1
		elif Global.health_player_2 <= 0:
			Global.score_player_1 += 1
		
		Global.health_player_1 = 100
		Global.health_player_2 = 100
		
		if Global.score_player_1 == 10 || Global.score_player_2 == 10:
			Global.score_player_1 = 0
			Global.score_player_2 = 0
			$Music.stream = sound_celebration
			$Music.play()
			$EndScreenBackground.visible = true
			$"Who won".visible = true
			$"Won how high?".visible = true
			$"Lost how high?".visible = true
			
			if Global.score_player_1 == 10:
				$"Who won".text = "Player 1 won!"
				$EndScreenBackground.color = "00a0a0"
				$"Lost how high?".modulate = Color(1, 0, 0)
				$"Lost how high?".text = (str(Global.score_player_2))
				
			else:
				$"Who won".text = "Player 2 won!"
				$EndScreenBackground.color = "940000"
				$"Lost how high?".modulate = Color(29, 255, 255)
				$"Lost how high?".text = (str(Global.score_player_1))
				
			await get_tree().create_timer(2.5).timeout
			$Restart.visible = true
			
		else:
			get_tree().reload_current_scene()


#-------------------------------------------------------------------


func someoneWon3():
	if Global.health_player_1 <= 0 || Global.health_player_2 <= 0:
		Global.game_paused = true
		Global.health_player_1 = 100
		Global.health_player_2 = 100
		triggerEndgame()


#-------------------------------------------------------------------



func triggerEndgame():
	
	if Global.score_player_1 >= 10 || Global.score_player_2 >= 10:
		
		$Music.stream = sound_celebration
		$Music.play()
		$EndScreenBackground.visible = true
		$"Who won".visible = true
		$"Won how high?".visible = true
		$"Lost how high?".visible = true
		
		Global.health_player_2 = 100
		Global.health_player_2 = 100

		if Global.score_player_1 >= 10:
			$"Who won".text = "Player 1 won!"
			$EndScreenBackground.color = "00a0a0"
			$"Lost how high?".modulate = Color(1, 0, 0)
			$"Lost how high?".text = (str(Global.score_player_2))
			Global.score_player_1 = 0

		elif Global.score_player_2 >= 10:
			$"Who won".text = "Player 2 won!"
			$EndScreenBackground.color = "940000"
			$"Lost how high?".modulate = Color(29/255.0, 255/255.0, 255/255.0)
			$"Lost how high?".text = (str(Global.score_player_1))
			Global.score_player_2 = 0

		$"End Match".visible = false
		await get_tree().create_timer(3.5).timeout
		$Restart.visible = true

	else:
		reset_players()


#-------------------------------------------------------------------


func reset_players():
	
	Engine.time_scale = 0.5
	await get_tree().create_timer(1).timeout
	Engine.time_scale = 1
	
	get_tree().reload_current_scene()
	
	Global.lavaRisngSpeed = 0.0005
	Global.lavaRisingCounter = 1
	$TileMap/Lava.position.x = 650
	
	Global.game_paused = false
	
	Engine.time_scale = 1


#------------------------------------------------------------------- 




func _on_restart_pressed() -> void:
	
	get_tree().reload_current_scene()
	
	$player_1.position = init_pos_player_1
	$player_2.position = init_pos_player_2
	Global.health_player_2 = 100
	Global.health_player_2 = 100
	
	Global.lavaRisngSpeed = 0.0005
	Global.lavaRisingCounter = 1
	$TileMap/Lava.position.x = 650
	
	Engine.time_scale = 1
	
	$"Who won".visible = false
	$"Won how high?".visible = false
	$"Lost how high?".visible = false
	$Restart.visible = false
	$"End Match".visible = true
	
	Global.game_paused = false




func _on_exit_game_pressed() -> void:
	pass
