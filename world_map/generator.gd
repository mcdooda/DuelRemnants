extends Node

func generate(plane_len, distance_between_points, path_count):
	# make sure that we are not going to generate the same map every time
	randomize()
	var center = Vector2(plane_len / 2, plane_len / 2)
	var region := Vector3(center.x, center.y, plane_len / 2)
	var poisson_sampler = preload("res://utils/poisson_disc_sampling.gd").new()
	var points = []
	# entry
	points.append(Vector2(-distance_between_points, plane_len / 2))
	# exit
	points.append(Vector2(plane_len + distance_between_points, plane_len / 2))
	var generated_points = poisson_sampler.generate_points(distance_between_points, region, 20)
	points += generated_points
	# step 2: connect all the points into a graph without intersecting edges
	var pool = PackedVector2Array(points)
	var triangles = Geometry2D.triangulate_delaunay(pool)
	
	# step 3: finding paths from start to finish using A*
	var astar = AStar2D.new()
	for i in range(points.size()):
		astar.add_point(i, points[i])
	
	#warning-ignore:integer_division
	var num_triangles := int(triangles.size() / 3.0)
	for i in num_triangles:
		var p1 = triangles[i * 3]
		var p2 = triangles[i * 3 + 1]
		var p3 = triangles[i * 3 + 2]
		if not astar.are_points_connected(p1, p2):
			astar.connect_points(p1, p2)
		if not astar.are_points_connected(p2, p3):
			astar.connect_points(p2, p3)
		if not astar.are_points_connected(p1, p3):
			astar.connect_points(p1, p3)
	
	var paths = []
	
	for i in range(path_count):
		var id_path = astar.get_id_path(0, 1)
		if id_path.size() == 0:
			break
		
		paths.append(id_path)
		# step 4: removing nodes / generating unique path every time
		for j in range(randi() % 2 + 1):
			# index between 1 and id_path.size() - 2 (inclusive)
			var index = randi() % (id_path.size() - 2) + 1
			
			var id = id_path[index]
			astar.set_point_disabled(id)
	
	var data = preload("res://world_map/map_data.gd").new()
	data.set_paths(paths, points)
	return data
