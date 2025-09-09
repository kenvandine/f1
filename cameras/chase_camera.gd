class_name ChaseCamera
extends Camera3D

@export var fixed = false
@export var lerp_speed = 6.0

var _position: Node3D = null

func _physics_process(delta: float):
	if not self._position:
		return

	global_transform = self._position.global_transform if self.fixed \
	else global_transform.interpolate_with(self._position.global_transform, self.lerp_speed * delta)


func _on_camera_position_changed(pos: Node3D):
	self._position = pos
