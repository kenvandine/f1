class_name Forest
extends MeshInstance3D

const Tree := preload("res://circuits/tree_large.tscn")

@export var count = 0
@export var max_tree_size = 5

@onready var size: Vector2 = (mesh as PlaneMesh).size


func _ready():
	var w := self.size.x/2
	var h := self.size.y/2
	for i in self.count:
		var tree := Tree.instantiate()
		add_child(tree)
		tree.global_translate(Vector3(randf_range(-w, w), 0.0, randf_range(-h, h)))
		tree.global_scale(Vector3(randf_range(1, self.max_tree_size), randf_range(1, self.max_tree_size), randf_range(1, self.max_tree_size)))
