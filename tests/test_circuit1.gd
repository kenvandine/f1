class_name TestCircuit1
extends Node3D

const RaceCar := preload("res://race_cars/race_car.tscn")
var race_car: RaceCar = RaceCar.instantiate()

@onready var chase_camera = $ChaseCamera
@onready var time_label = $CircuitControl/TimePanel/Container/TimeContainer/Label

var time_elapsed: float = 0.000
var started: bool = false

func _init():
	race_car.get_path_direction = Callable(self, "get_path_direction")
	pass

func _ready():
	add_child(race_car)
	race_car.translate(Vector3(-11.772, 0.1, 1.232))

	race_car.connect("camera_position_changed", Callable(chase_camera, "_on_camera_position_changed"))
	race_car.init_camera_position() # warning-ignore:return_value_discarded

	time_label.text = ("%07.3f" % time_elapsed)
	$RoadStart.lights_timer.start()


func _process(delta: float):
	time_elapsed += delta
	if started:
		time_label.text = ("%07.3f" % time_elapsed)


func _on_lights_out():
	time_elapsed = 0.0
	race_car.set_physics_process(true)
	self.started = true


func _on_start_body_entered(body: RaceCar):
	print("ID: ", body.get_instance_id(), " V: ", body._velocity.length() )


func get_path_direction(pos: Vector3) -> Vector3:
	var offset: float = $Path.curve.get_closest_offset(pos)
	$Path/PathFollow.progress = offset
	return $Path/PathFollow.transform.basis.z
