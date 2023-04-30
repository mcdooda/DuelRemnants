extends Node

var paths = []
var nodes = {}

func set_paths(generated_paths, points):
	paths = generated_paths
	
	for path in paths:
		for id in path:
			nodes[id] = points[id]
