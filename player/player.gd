extends RigidBody3D
class_name Player

@export_range(750,2500) var force := 1000.0
@export var torque_thrust := 100

var transitioning := false
@onready var explosionaudio: AudioStreamPlayer = $explosionaudio
@onready var successaudio: AudioStreamPlayer = $successaudio
@onready var rocketaudio: AudioStreamPlayer3D = $rocketaudio



func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if not transitioning:
		if Input.is_action_pressed("boost"):
			apply_central_force(basis.y*delta*force)
			if not rocketaudio.is_playing():
				rocketaudio.play()
		else:
			rocketaudio.stop()
		if Input.is_action_pressed("rotateleft"):
			apply_torque(Vector3(0.0,0.0,delta*torque_thrust))
		if Input.is_action_pressed("rotateright"):
			apply_torque(Vector3(0.0,0.0,-delta*torque_thrust))





func _on_body_entered(body: Node) -> void:
	
	if "goal" in body.get_groups():
		
		if body.file_path:
			complete_level(body.file_path)
		else:
			print("error: no level found")
		
	if "terrain" in body.get_groups():
		
		crash_sequence()
		
func crash_sequence():
	
	transitioning = true
	freeze = true
	explosionaudio.play()
	await get_tree().create_timer(1).timeout
	
	print("boom")
	get_tree().reload_current_scene.call_deferred()

func complete_level(next_level_file):
	transitioning = true
	freeze = true
	successaudio.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file.call_deferred(next_level_file)
