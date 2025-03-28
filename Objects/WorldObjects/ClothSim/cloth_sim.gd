@tool
extends Node2D

@export_tool_button("GenerateMesh", "Callable") var genMesh = generateMesh

# Cloth settings
var particle_count_x = 24
var particle_count_y = 8
var particle_spacing = 2.0
var gravity = Vector2(0, 0.5)
var outsideForces = Vector2(0.0, 0.0)
var constraint_iterations = 3

# Particles and constraints
var particles = []
var constraints = []

# Collision circle (example)
var circle_pos = Vector2(400, 300)
var circle_radius = 50.0

func _ready():
	generateMesh()
	# Initialize cloth particles
	for y in range(particle_count_y):
		for x in range(particle_count_x):
			var pos = Vector2(
				x * particle_spacing,
				y * particle_spacing
			)
			particles.append({
				"pos": pos,
				"prev_pos": pos,
				"pinned": (y == 0 or x == 0 or x == particle_count_x -1)  # Pin top row
			})

	# Create structural constraints (horizontal + vertical)
	for y in range(particle_count_y):
		for x in range(particle_count_x):
			var idx = y * particle_count_x + x
			if x < particle_count_x - 1:
				constraints.append([idx, idx + 1, particle_spacing])
			if y < particle_count_y - 1:
				constraints.append([idx, idx + particle_count_x, particle_spacing])
	
	#$AnimationPlayer.play("Idle")

var prevPos : Vector2
func _physics_process(delta_time):
	#circle_pos = get_global_mouse_position()
	#position = get_global_mouse_position()
	
	if !prevPos:
		prevPos = global_position
	else:
		outsideForces = prevPos - global_position
		outsideForces *= 0.3
		prevPos = global_position
	
	simulate(delta_time)
	queue_redraw()  # Redraw every frame
	
	var mesh : Array[Vector2] = []
	for p in particles:
		mesh.append(p.pos)
	%MeshInstance2D.material.set_shader_parameter("mesh", mesh)

func simulate(delta_time):
	# Apply Verlet integration (gravity + inertia)
	for p in particles:
		if p["pinned"]:
			continue
		var temp = p["pos"]
		var dif = (p["pos"] - p["prev_pos"])
		p["pos"] += dif + gravity * delta_time * 60.0 + outsideForces * delta_time * 60.0 # Scale by delta
		p["prev_pos"] = temp

	# Solve distance constraints (PBD-style)
	for _iter in range(constraint_iterations):
		for c in constraints:
			var p1 = particles[c[0]]
			var p2 = particles[c[1]]
			var rest_length = c[2]
			
			var delta_vec = p2["pos"] - p1["pos"]
			var dist = delta_vec.length()
			if dist == 0:
				continue
			
			var correction = delta_vec * (dist - rest_length) / dist * 0.5
			
			if not p1["pinned"]:
				p1["pos"] += correction
			if not p2["pinned"]:
				p2["pos"] -= correction

	# Collision with circle
	#for p in particles:
		#if p.pinned == false:
			#if (p["pos"] - circle_pos).length() < circle_radius:
				#var dir = (p["pos"] - circle_pos).normalized()
				#p["pos"] = circle_pos + dir * circle_radius

func _draw():
	return
	# Draw constraints (lines between particles)
	for c in constraints:
		var p1 = particles[c[0]]
		var p2 = particles[c[1]]
		draw_line(p1["pos"], p2["pos"], Color(0.8, 0.8, 0.8), 1.0)

	# Draw particles
	for p in particles:
		draw_circle(p["pos"], 2.0, Color(1, 1, 1))

	# Draw collision circle (for debugging)
	draw_circle(circle_pos, circle_radius, Color(1, 0, 0, 0.5), false)

func generateMesh():
	var mesh_instance = %MeshInstance2D
	var arr_mesh = ArrayMesh.new()
	var arrays := []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	
	# Vertices
	var vertices := PackedVector2Array()
	for y in range(particle_count_y):
		for x in range(particle_count_x):
			vertices.append(Vector2(x * particle_spacing, y * particle_spacing))
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	
	# UVs
	var uvs := PackedVector2Array()
	for y in range(particle_count_y):
		for x in range(particle_count_x):
			uvs.append(Vector2(
				float(x) / (particle_count_x - 1),
				float(y) / (particle_count_y - 1)
			))
	arrays[ArrayMesh.ARRAY_TEX_UV] = uvs
	
	# Indices (triangles)
	var indices := PackedInt32Array()
	for y in range(particle_count_y - 1):
		for x in range(particle_count_x - 1):
			var tl = y * particle_count_x + x
			var tr = tl + 1
			var bl = tl + particle_count_x
			var br = bl + 1
			indices.append_array([tl, bl, tr, tr, bl, br])
	arrays[ArrayMesh.ARRAY_INDEX] = indices
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh_instance.mesh = arr_mesh
