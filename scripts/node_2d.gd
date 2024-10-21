extends Node2D

var cameraZoomCounter1 = 500
const cameraZoomNormal = Vector2(2, 2)
const cameraZoomZoom = Vector2(1, 1)

#--------------------------------------------------------------------

func _ready() -> void:

	$Camera2D.zoom = 2.21
			#2.21 --> 2560 x 1440
			#x.xx --> 1080 x 720
			
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


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(1000)
