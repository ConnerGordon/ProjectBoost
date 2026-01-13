extends MeshInstance3D
@onready var pillar: MeshInstance3D = $pillar
@onready var pillar_2: MeshInstance3D = $pillar2
@onready var pillar_3: MeshInstance3D = $pillar3
@onready var pillar_4: MeshInstance3D = $pillar4
@onready var timer: Timer = $Timer

var x : float = 0
func _process(delta: float) -> void:
	x+=.05
	print(x)
	pillar.position = Vector3(cos(x)*-.482,-.228,sin(x)*.482)
	pillar_2.position = Vector3(cos(x)*-.482,-.228,sin(x)*-.482)
	pillar_3.position = Vector3(cos(x)*.482,-.228,sin(x)*-.482)
	pillar_4.position = Vector3(cos(x)*.482,-.228,sin(x)*.482)
