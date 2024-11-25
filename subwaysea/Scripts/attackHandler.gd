extends Node

signal wasAttacked
signal MainInitialized

@onready var randomAttackTimer = find_child("AttackTimer")
@onready var fadeIn: ColorRect = $ColorRect
var dead = false
var attack_time = 120

func _process(delta: float) -> void:
	if dead and fadeIn.color.a < 1.0:
		fadeIn.color.a += 0.5 * delta
	elif fadeIn.color.a >= 1.0:
		dead = false
		get_tree().reload_current_scene()


func _ready() -> void:
	randomAttackTimer.wait_time = randi_range(60,300)
	randomAttackTimer.autostart = true
	MainInitialized.emit()


# function needs to be called when the monster or anything else triggers an attack event
# called on instantiated debris click event
func callForAttack():
	emitWasAttacked()

#emit signal to all machines that their was an attack
func emitWasAttacked():
	var randValue = randi_range(0,10)
	wasAttacked.emit(randValue)
	# connect to OxygenMachine.gd and breakerBox.gd and camera.gd

# call attack on end of timer then reset the time to be somethign else
func _on_attack_timer_timeout() -> void:
	callForAttack()
	
	randomAttackTimer.wait_time = randi_range(120,600)

func death():
	dead = true
