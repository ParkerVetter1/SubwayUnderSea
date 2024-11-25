extends Node2D

@onready var label: Label = $Label
@export var depth: int
@onready var fadeIn: ColorRect = $ColorRect
@onready var surfacing_label: Label = $"CanvasLayer/surfacing label"
var dots = ""
var alpha = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateGauge()
	surfacing_label.visible = false

func _process(delta: float) -> void:
	if depth < 12 and fadeIn.color.a < 1.0:
		fadeIn.color.a += 0.1 * delta

func updateGauge():
	label.set_text("Depth: " + str(depth) + "m") #chagee the text to depth with m for meters
	await awaitTimer() #wait for await

func awaitTimer():
	if depth > 0: #if depth is not 0, then decrease it by 1
		depth -= 1
		await get_tree().create_timer(1).timeout #create a timer and wait until it finishes
		updateGauge() #run this loop again
		if depth <= 10:
			surfacing_label.visible = true
			# dude this dots code is the stupidest thing i have ever written
			if dots != "...":
				dots += "."
			else:
				dots = ""
			surfacing_label.set_text("SURFACING" + dots)
	else:
		get_tree().change_scene_to_file("res://Scenes/WinMenu/WinScene.tscn") #when depth reaches 0 (surface), then return to main menu
