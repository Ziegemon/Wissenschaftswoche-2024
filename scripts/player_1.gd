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
var health = 100
var alive = true


func _physics_process(delta: float) -> void:
	
	borderTeleport($".")
	
	if health <= 0:
		alive = false
	if alive == true:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		if rolling == false:
			if attacking == false:
				# Handle jump.
				if Input.is_action_just_pressed("jump_p_1") and is_on_floor():
					velocity.y = JUMP_VELOCITY
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			if attacking == false:
				if Input.is_action_pressed("move_left_p_1"):
					direction = -1
				elif Input.is_action_pressed("move_right_p_1"):
					direction = 1
				else:
					direction = 0
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
				if is_on_floor():
					if Input.is_action_just_pressed("attack_1_p_1"):
						animation_player.play("attack_1")
						attack_cooldown.start(0.5)
						attacking = true
					if Input.is_action_just_pressed("attack_2_p_1"):
						animation_player.play("attack_2")
						attack_cooldown.start(1)
						attacking = true
					if Input.is_action_just_pressed("double_attack_p_1"):
						animation_player.play("attack_3")
						attack_cooldown.start(1.5)
						attacking = true
			if attacking == false:
				if is_on_floor():
					if direction == 0:
						animated_sprite_2d.play("idle")
					else:
						animated_sprite_2d.play("run")
				else:
					animated_sprite_2d.play("jump")
			else:
				velocity.x = 0
		
		if Input.is_action_just_pressed("roll_p_1") and can_roll:
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
			Engine.time_scale = 0.5
			$reset_timer.start()
			

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
	if body.has_method("player_2"):
		if animation_player.current_animation == "attack_1":
			body.take_damage(20)
		if animation_player.current_animation == "attack_2":
			body.take_damage(30)
		if animation_player.current_animation == "attack_3":
			body.take_damage(40)

func take_damage(damage):
	health -= damage

func player_1():
	pass


func _on_reset_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func borderTeleport(body: CharacterBody2D):
	if body.position.x <= 0:
		body.position.x = 1147
	elif body.position.x >= 1151:
		body.position.x = 1
