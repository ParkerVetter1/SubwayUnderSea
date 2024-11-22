extends RigidBody2D

@onready var detect_player: Area2D = $DetectPlayer
@onready var detect_machine: Area2D = $DetectMachine

@onready var player = get_tree().get_first_node_in_group('player')

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('interact') and detect_player.has_overlapping_bodies and detect_player.get_overlapping_bodies()[0].holding_c == []:
		detect_player.get_overlapping_bodies()[0].holding_c += [self]
		print(detect_player.get_overlapping_bodies()[0].holding_c)
		freeze = true
		$CollisionShape2D.disabled = true
	
	if detect_machine.has_overlapping_bodies():
		if detect_machine.get_overlapping_bodies()[0].has_method('repair'):
			detect_machine.get_overlapping_bodies()[0].repair()
			die()

func die():
	#play animation
	detect_player.get_overlapping_bodies()[0].holding_c.erase(self)
	await get_tree().create_timer(1).timeout
	queue_free()
	
