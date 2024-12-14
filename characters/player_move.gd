extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec

#var Tween tween

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	#print("direction ", direction)  方向向量
	
	velocity = direction * speed

	move_and_slide()
