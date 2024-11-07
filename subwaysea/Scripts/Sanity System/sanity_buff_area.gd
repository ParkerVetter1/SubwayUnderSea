extends Area2D
@onready var sanity_buff_area: Area2D = $"."
@onready var sanity_debuff_area: Area2D = $"."

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var overlapping_bodies_list = get_overlapping_bodies()
	for body in overlapping_bodies_list:
		if body.has_method("change_sanity"):
			# access "change_sanity" function in player code to change sanity value
			body.change_sanity(0.1)