extends Node

signal wasAttacked
signal MainInitialized

@onready var randomAttackTimer = find_child("AttackTimer")

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	randomAttackTimer.wait_time = randi_range(120,600)
	randomAttackTimer.autostart = true
	MainInitialized.emit()


# function needs to be called when the monster or anything else triggers an attack event
# called in supplygrabber
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
