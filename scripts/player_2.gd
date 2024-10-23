extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_cooldown: Timer = $attack_cooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const DASH_SPEED = 1.4
const SPEED = 200.0
const JUMP_VELOCITY = -425.0

var attacking = false
var rolling = false
var can_roll = true
var direction = 0
var alive = true

var sound_attack_1 = preload("res://sounds/sword-sound-effect-1.mp3")
var sound_attack_2 = preload("res://sounds/sword-sound-effect-2.mp3")
var sound_jump = preload("res://sounds/Mario_jump_sound.mp3")
var sound_damage_uhh = preload("res://sounds/uhh_hurt.mp3")

func _physics_process(delta: float) -> void:
	
	borderTeleport($".")
	healthbarUpdate()
	raiseGame()
	
	if Global.game_paused == false:
		if Global.health_player_2 <= 0:
			alive = false
		if alive == true:
			# Add the gravity.
			if not is_on_floor():
				velocity += get_gravity() * delta
			if rolling == false:
				
				if attacking == false || animation_player.current_animation == "attack_1":
						# Handle jump.
					if Input.is_action_just_pressed("jump_p_2") and is_on_floor():
						velocity.y = JUMP_VELOCITY
						$Sound_attack_player_2.stream = sound_jump
						$Sound_attack_player_2.play()
				# Get the input direction and handle the movement/deceleration.
				# As good practice, you should replace UI actions with custom gameplay actions.
				if attacking == false:
					if Input.is_action_pressed("move_left_p_2"):
						direction = -1
					elif Input.is_action_pressed("move_right_p_2"):
						direction = 1
					else:
						direction = 0
				elif animation_player.current_animation == "attack_1":
					pass
				else:
					direction = 0
				if direction:
					velocity.x = direction * SPEED
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
					
				if direction == 1:
					$AnimatedSprite2D.scale.x = 1
					$CollisionShape2D.scale.x = 1
				if direction == -1:
					$AnimatedSprite2D.scale.x = -1
					$CollisionShape2D.scale.x =-1
				if attacking == false:
					
					if Input.is_action_just_pressed("attack_1_p_2"):
							animation_player.play("attack_1")
							attack_cooldown.start(0.5)
							Input.start_joy_vibration(0,1,0,0.3)
							attacking = true
							$Sound_attack_player_2.stream = sound_attack_1
							$Sound_attack_player_2.play()
							
					if is_on_floor():

						if Input.is_action_just_pressed("attack_2_p_2"):
							animation_player.play("attack_2")
							attack_cooldown.start(1)
							attacking = true
							await get_tree().create_timer(0.25).timeout
							$Sound_attack_player_2.stream = sound_attack_2
							$Sound_attack_player_2.play()
							Input.start_joy_vibration(0,1,0,0.4)
							
						if Input.is_action_just_pressed("double_attack_p_2"):
							animation_player.play("attack_3")
							attack_cooldown.start(1.5)
							Input.start_joy_vibration(0,1,0,0.4)
							attacking = true
							$Sound_attack_player_2.stream = sound_attack_1
							$Sound_attack_player_2.play()
							await get_tree().create_timer(0.5).timeout
							$Sound_attack_player_2.stream = sound_attack_2
							$Sound_attack_player_2.play()
							Input.start_joy_vibration(0,1,0,0.4)
							
				if attacking == false:
					if is_on_floor():
						if direction == 0:
							animated_sprite_2d.play("idle")
						else:
							animated_sprite_2d.play("run")
					else:
						animated_sprite_2d.play("jump")
				elif animation_player.current_animation == "attack_1":
					pass
				else:
					velocity.x = 0
			
			if Input.is_action_just_pressed("roll_p_2") and can_roll:
				$roll_timer.start()
				$roll_cooldown.start()
				can_roll = false
				rolling = true
				$AnimatedSprite2D.play("roll")
				velocity.x = animated_sprite_2d.scale.x * SPEED * DASH_SPEED
			move_and_slide()
		else:
			if animated_sprite_2d.animation != "death":
				animated_sprite_2d.play("death")
				$ProgressBar.visible = false
				#$reset_timer.start()

func _on_attack_cooldown_timeout() -> void:
	attacking = false


func _on_roll_timer_timeout() -> void:
	rolling = false
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _on_roll_cooldown_timeout() -> void:
	can_roll = true


func _on_sword_hit_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("player_1"):
		if animation_player.current_animation == "attack_1":
			body.take_damage(15)
			$Sound_attack_player_2.stream = sound_damage_uhh
			$Sound_attack_player_2.play()
		if animation_player.current_animation == "attack_2":
			body.take_damage(35)
			$Sound_attack_player_2.stream = sound_damage_uhh
			$Sound_attack_player_2.play()
		if animation_player.current_animation == "attack_3":
			body.take_damage(30)
			$Sound_attack_player_2.stream = sound_damage_uhh
			$Sound_attack_player_2.play()

func take_damage(damage):
	Global.health_player_2 -= damage
	if Global.health_player_2 <= 0:
		Global.score_player_1 += 1
		Global.player_died = true

func player_2():
	pass

func _on_reset_timer_timeout() -> void:
	if Global.score_player_1 < 10 && Global.score_player_2 < 10:
		Engine.time_scale = 1
		$ProgressBar.visible = true
		Global.health_player_1 = 100
		Global.health_player_2 = 100
		get_tree().reload_current_scene()

func borderTeleport(body: CharacterBody2D):
	if body.position.x <= 0:
		body.position.x = 1147
	elif body.position.x >= 1151:
		body.position.x = 1


func healthbarUpdate():
	$ProgressBar.value = Global.health_player_2


func raiseGame():
	if Global.lavaAtCerteinHeight == true:
		$ProgressBar.position.y = $ProgressBar.position.y - 0.036
