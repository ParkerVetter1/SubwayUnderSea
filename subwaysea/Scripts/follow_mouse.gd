extends PointLight2D

@onready var ray: RayCast2D = $RayCast2D #get a reference to the raycast
@onready var target

func _process(delta: float) -> void: 
	look_at(get_global_mouse_position())
	isRayColliding()

func isRayColliding():
	if ray.is_colliding(): #checks if the ray is colliding
		target = ray.get_collider() #creates a var called target
		if (target.get_parent().name == "OxygenSystem"): #checks if the target is a specific target
			target.get_parent().changeSprite()
			print("Oxygen System changed")
		elif (target.get_parent().name == "BreakerBox"):
			target.get_parent().changeSprite()
