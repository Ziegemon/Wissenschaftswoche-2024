extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$EndScreenBackground.visible = false
	#$"Who won".visible = false
	#$"Won how high?".visible = false
	#$"Lost how high?".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	triggerEndgame()


func triggerEndgame():
	if Global.triggerEndgame == true:
		if Global.player_died == true:
			Global.player_died = false
			
			if Global.score_player_1 >= 10 || Global.score_player_2 >= 10:
				Global.resetStage_2 = true
				Global.game_paused = true
				#$Music.stream = sound_celebration
				#$Music.play()
				$EndScreenBackground.visible = true
				$"Who won".visible = true
				$"Won how high?".visible = true
				$"Lost how high?".visible = true

				if Global.score_player_1 >= 10:
					$"Who won".text = "Player 1 won!"
					$EndScreenBackground.color = "00a0a0"
					$"Lost how high?".modulate = Color(1, 0, 0)
					$"Lost how high?".text = (str(Global.score_player_2))
					Global.score_player_1 = 0
					for n in 20:
						$"Who won".scale = Vector2(1.5, 1.5)
						await get_tree().create_timer(0.2).timeout
						$"Who won".scale = Vector2(1, 1)
						await get_tree().create_timer(0.2).timeout

				elif Global.score_player_2 >= 10:
					$"Who won".text = "Player 2 won!"
					print("jdfnglhfdblfdgdfgdffgfgjfghj-----------")
					$EndScreenBackground.color = "940000"
					$"Lost how high?".modulate = Color(29/255.0, 255/255.0, 255/255.0)
					$"Lost how high?".text = (str(Global.score_player_1))
					Global.score_player_2 = 0

					Global.resetStage_4 = true
					for n in 25:
							$"Who won".scale = Vector2(1.5, 1.5)
							await get_tree().create_timer(0.2).timeout
							$"Who won".scale = Vector2(1, 1)
							await get_tree().create_timer(0.2).timeout
				Global.resetStage_3 = true

			else:
				Global.resetStage_1 = true


func resetEndscreen():
	if Global.resetEndscreen == true:
		Global.resetEndscreen = false
		$"Who won".visible = false
		$"Won how high?".visible = false
		$"Lost how high?".visible = false
