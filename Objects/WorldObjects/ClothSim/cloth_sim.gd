@tool
extends Node2D

@export_tool_button("GenerateMesh", "Callable") var genMesh = generateMesh
@export var texture : Texture2D
@export var outlineColor : Color = Color.WHITE #Not Implemented
@export var clothAngle : float #Not Implemented
@export var offset : Vector2 = Vector2.ZERO
# Cloth settings
@export_group("Cloth Settings")
@export var collidable : bool = true #collision not working for some reason
@export var particle_count_x : int = 24
@export var particle_count_y : int = 8
@export var particle_spacing : float = 2.0
@export var movementForceMultiplier : float = 0.3
@export_subgroup("Forces")
@export var gravity = Vector2(0, 0.5)
@export var windAmplitude : float = 4.0;
@export var windSpeed : float = 1.5;
@export var windNoiseScale : float = 0.7;
@export_subgroup("Contraints")
@export var lockLeft : bool = false
@export var lockRight : bool = false
@export var lockTop : bool = false
@export var lockBottom : bool = false

var outsideForces = Vector2(0.0, 0.0)
var constraint_iterations : int = 3

# Particles and constraints
var particles = []
var constraints = []

# Collision circle (example)
var circle_pos = Vector2(400, 300)
var circle_radius = 50.0

func _ready():
	generateMesh()

func _process(_delta: float) -> void:
	$Sprite2D.material.set_shader_parameter("modulate", modulate)

func populateParticles():
	particles.clear()
	for y in range(particle_count_y):
		for x in range(particle_count_x):
			var pos = Vector2(
				x * particle_spacing,
				y * particle_spacing
			)
			particles.append({
				"pos": pos,
				"prev_pos": pos,
				"coordinate": Vector2(x, y),
				"pinned": isPinned(x, y)
			
			})

func isPinned(x, y) -> bool:
	if lockLeft:
		if x == 0:
			return true
		
	if lockRight:
		if x == particle_count_x - 1:
			return true
			
	if lockTop:
		if y == 0:
			return true
	
	if lockBottom:
		if y == particle_count_y - 1:
			return true
	
	return false

func polpulateContraints():
	constraints.clear()
	for y in range(particle_count_y):
		for x in range(particle_count_x):
			var idx = y * particle_count_x + x
			if x < particle_count_x - 1:
				constraints.append([idx, idx + 1, particle_spacing])
			if y < particle_count_y - 1:
				constraints.append([idx, idx + particle_count_x, particle_spacing])

var prevPos : Vector2
func _physics_process(delta_time):
	
	if !prevPos:
		prevPos = global_position
	else:
		outsideForces = prevPos - global_position
		outsideForces *= Vector2(movementForceMultiplier, movementForceMultiplier)
		prevPos = global_position
	
	simulate(delta_time)
	queue_redraw()  # Redraw every frame
	
	var mesh : Array[Vector2] = []
	var pins : Array[bool] = []
	for p in particles:
		mesh.append(p.pos)
		pins.append(p["pinned"])
	
	for i in range(500 - particles.size()):
		mesh.append(Vector2.ZERO)
		pins.append(false)
	%MeshInstance2D.material.set_shader_parameter("mesh", mesh)
	%MeshInstance2D.material.set_shader_parameter("pinned", pins)
	%MeshInstance2D.material.set_shader_parameter("windAmplitude", windAmplitude)
	%MeshInstance2D.material.set_shader_parameter("windSpeed", windSpeed)
	%MeshInstance2D.material.set_shader_parameter("noiseScale", windNoiseScale)

func simulate(delta_time):
	# Apply Verlet integration (gravity + inertia)
	for p in particles:
		if p["pinned"]:
			continue
		var temp = p["pos"]
		var dif = (p["pos"] - p["prev_pos"])
		
		#var yMul : float = (1.0 - (particle_count_y - p["coordinate"].y) / particle_count_y)
		#dif.y *= yMul;
		#dif.x *= 0.7
		dif *= 0.7;
		p["pos"] += dif + gravity * delta_time * 60.0 + outsideForces # Scale by delta
		p["prev_pos"] = temp

	# Solve distance constraints (PBD-style)
	for _i in range(constraint_iterations):
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
	if collidable:
		var spaceState := get_world_2d().direct_space_state
		for p in particles:
			if p.pinned:
				continue
			
			var pos = p["pos"] + global_position + offset
			# Check for collisions using a small shape (circle query)
			var query := PhysicsPointQueryParameters2D.new()
			query.position = pos
			query.collision_mask = pow(2, 9)  # Match obstacle's collision layer
			query.collide_with_bodies = true
			query.collide_with_areas = true
			
			var results := spaceState.intersect_point(query)
			if not results.is_empty():
				# Push particle out of the obstacle
				var coll = results[0].collider
				var obstacle_pos = coll.global_position
				var obstacle_shape = results[0].shape
				
				
				# Handle different obstacle shapes (example: CircleShape2D)
				if obstacle_shape == 0:
					var radius = 5.0
					var dir = (pos - obstacle_pos).normalized()
					p["pos"] = (obstacle_pos - global_position - offset) + dir * (radius)  # +2.0 for slight offset


func _draw():
	return
	# Draw constraints (lines between particles)
	for c in constraints:
		var p1 = particles[c[0]]
		var p2 = particles[c[1]]
		draw_line(p1["pos"], p2["pos"], Color(0.8, 0.8, 0.8), 1.0)

	# Draw particles
	for p in particles:
		draw_circle(p["pos"], 0.5, Color(1, 1, 1))

	# Draw collision circle (for debugging)
	draw_circle(circle_pos, circle_radius, Color(1, 0, 0, 0.5), false)

func generateMesh():
	%MeshInstance2D.texture = texture
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
	
	populateParticles()
	polpulateContraints()
