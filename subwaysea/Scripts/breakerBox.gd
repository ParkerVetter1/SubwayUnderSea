extends StaticBody2D


var currentSprite = load("res://assets/Light Machine ON.png")

@onready var sprite: Sprite2D = $Sprite2D
@onready var fixedSprite = load("res://assets/Light Machine ON.png")
@onready var brokenSprite = load("res://assets/Light Machine OFF.png")
@onready var blinkingSprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var lightParent = self.get_parent().find_child("LightParent")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blinkingSprite.visible = false
	self.get_parent().connect("wasAttacked", Callable(self, "wasAttacked"))

func wasAttacked(randomValue):
	if randomValue <= 3:
		if currentSprite == fixedSprite:
			lightParent.flickerOff()
		currentSprite = brokenSprite
		$WorkingAudio.stop()
		$light.energy = 0

func repair():
	if currentSprite == brokenSprite:
		lightParent.flickerOn()
		currentSprite = fixedSprite
		$Fixed.play()
		$light.energy = 2
		return true

#set the sprite texture to the variable currentSprite
func changeSprite():
	sprite.texture = currentSprite
	if currentSprite == brokenSprite:
		blinkingSprite.visible = true
	else:
		blinkingSprite.visible = false

#function to change the check the sprite and change the currentSprite variable
func hasSpriteChanged():
	if sprite.texture == fixedSprite:
		currentSprite = brokenSprite
	elif  sprite.texture == brokenSprite:
		currentSprite = fixedSprite

func _process(delta: float) -> void:
	if currentSprite == fixedSprite and $WorkingAudio.playing == false:
		$WorkingAudio.play()
