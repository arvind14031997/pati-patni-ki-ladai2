extends Control
class_name CharacterArt

## Original vector-drawn character. No external artwork is needed.

var gender := "husband"
var expression := "happy"
var accent := Color("#5B57C9")
var skin := Color("#C9825F")
var hair := Color("#241A35")
var tilt := 0.0

func _ready() -> void:
	custom_minimum_size = Vector2(205, 270)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	queue_redraw()

func set_character(new_gender: String, new_expression: String) -> void:
	gender = new_gender
	expression = new_expression
	if gender == "wife":
		accent = Color("#E65D76")
		skin = Color("#C9825F")
		hair = Color("#332041")
	else:
		accent = Color("#5A58C9")
		skin = Color("#D28E6C")
		hair = Color("#241A35")
	queue_redraw()

func celebrate() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.12, 0.9), 0.12)
	tween.tween_property(self, "scale", Vector2(0.92, 1.12), 0.12)
	tween.tween_property(self, "scale", Vector2.ONE, 0.18)

func shake() -> void:
	var tween := create_tween()
	tween.tween_property(self, "rotation", -0.07, 0.06)
	tween.tween_property(self, "rotation", 0.07, 0.06)
	tween.tween_property(self, "rotation", -0.04, 0.06)
	tween.tween_property(self, "rotation", 0.0, 0.08)

func _draw() -> void:
	var w := size.x
	var h := size.y
	var cx := w * 0.5
	var head_center := Vector2(cx, h * 0.35)

	# Soft grounding shadow.
	draw_ellipse(Vector2(cx, h - 22.0), Vector2(w * 0.30, 13.0), Color(0.02, 0.01, 0.07, 0.22))

	# Torso and clothing.
	var body := PackedVector2Array([
		Vector2(cx - w * 0.30, h * 0.98),
		Vector2(cx - w * 0.24, h * 0.64),
		Vector2(cx, h * 0.57),
		Vector2(cx + w * 0.24, h * 0.64),
		Vector2(cx + w * 0.30, h * 0.98),
	])
	draw_colored_polygon(body, accent)
	draw_line(Vector2(cx - w * 0.20, h * 0.69), Vector2(cx - w * 0.08, h * 0.98), Color(1, 1, 1, 0.2), 4.0)
	draw_line(Vector2(cx + w * 0.20, h * 0.69), Vector2(cx + w * 0.08, h * 0.98), Color(0.05, 0.04, 0.15, 0.18), 4.0)

	if gender == "husband":
		draw_colored_polygon(PackedVector2Array([
			Vector2(cx - 23, h * 0.67), Vector2(cx, h * 0.84),
			Vector2(cx + 23, h * 0.67), Vector2(cx + 10, h * 0.98),
			Vector2(cx - 10, h * 0.98)
		]), Color("#F6B73C"))
		draw_line(Vector2(cx, h * 0.84), Vector2(cx, h * 0.98), Color("#281D47"), 3.0)
	else:
		draw_arc(Vector2(cx, h * 0.77), w * 0.18, 0.1, PI - 0.1, 18, Color("#F5D1C3"), 5.0)

	# Neck, ears, and face.
	draw_rect(Rect2(cx - 16, h * 0.51, 32, 38), skin, true)
	draw_circle(Vector2(cx - w * 0.205, h * 0.35), 18.0, skin)
	draw_circle(Vector2(cx + w * 0.205, h * 0.35), 18.0, skin)
	draw_circle(head_center, w * 0.235, skin)

	# Hair silhouette.
	if gender == "husband":
		var hair_shape := PackedVector2Array([
			Vector2(cx - w * 0.24, h * 0.36),
			Vector2(cx - w * 0.28, h * 0.22),
			Vector2(cx - w * 0.16, h * 0.09),
			Vector2(cx - w * 0.02, h * 0.13),
			Vector2(cx + w * 0.12, h * 0.06),
			Vector2(cx + w * 0.27, h * 0.20),
			Vector2(cx + w * 0.22, h * 0.34),
			Vector2(cx + w * 0.12, h * 0.23),
			Vector2(cx - w * 0.15, h * 0.23)
		])
		draw_colored_polygon(hair_shape, hair)
	else:
		draw_circle(Vector2(cx, h * 0.25), w * 0.285, hair)
		draw_colored_polygon(PackedVector2Array([
			Vector2(cx - w * 0.28, h * 0.25), Vector2(cx - w * 0.30, h * 0.63),
			Vector2(cx - w * 0.19, h * 0.70), Vector2(cx - w * 0.18, h * 0.32)
		]), hair)
		draw_colored_polygon(PackedVector2Array([
			Vector2(cx + w * 0.28, h * 0.25), Vector2(cx + w * 0.30, h * 0.63),
			Vector2(cx + w * 0.19, h * 0.70), Vector2(cx + w * 0.18, h * 0.32)
		]), hair)
		draw_circle(Vector2(cx - w * 0.29, h * 0.20), 7.0, Color("#E65D76"))

	# Eyes and eyebrows change with the selected mood.
	var eye_y := h * 0.35
	var eye_dx := w * 0.085
	if expression == "angry":
		draw_line(Vector2(cx - eye_dx - 10, eye_y - 10), Vector2(cx - eye_dx + 7, eye_y - 3), hair, 5.0)
		draw_line(Vector2(cx + eye_dx - 7, eye_y - 3), Vector2(cx + eye_dx + 10, eye_y - 10), hair, 5.0)
	else:
		draw_line(Vector2(cx - eye_dx - 8, eye_y - 7), Vector2(cx - eye_dx + 8, eye_y - 7), hair, 4.0)
		draw_line(Vector2(cx + eye_dx - 8, eye_y - 7), Vector2(cx + eye_dx + 8, eye_y - 7), hair, 4.0)
	draw_circle(Vector2(cx - eye_dx, eye_y), 5.0, hair)
	draw_circle(Vector2(cx + eye_dx, eye_y), 5.0, hair)
	draw_circle(Vector2(cx - eye_dx + 1, eye_y - 1), 1.6, Color.WHITE)
	draw_circle(Vector2(cx + eye_dx + 1, eye_y - 1), 1.6, Color.WHITE)

	if expression == "happy" or expression == "laughing":
		draw_arc(Vector2(cx, h * 0.43), 20.0, 0.15, PI - 0.15, 18, hair, 5.0)
	elif expression == "surprised":
		draw_circle(Vector2(cx, h * 0.44), 10.0, Color("#6D314C"))
	elif expression == "confused":
		draw_arc(Vector2(cx, h * 0.44), 15.0, PI + 0.2, TAU - 0.2, 16, hair, 4.0)
	else:
		draw_line(Vector2(cx - 16, h * 0.45), Vector2(cx + 15, h * 0.45), hair, 5.0)

	# Small sparkle makes the characters feel lively without external sprites.
	if expression == "laughing" or expression == "surprised":
		draw_line(Vector2(18, 30), Vector2(18, 48), Color("#F6B73C"), 4.0)
		draw_line(Vector2(9, 39), Vector2(27, 39), Color("#F6B73C"), 4.0)
		draw_line(Vector2(w - 18, 48), Vector2(w - 18, 66), Color("#F6B73C"), 4.0)
		draw_line(Vector2(w - 27, 57), Vector2(w - 9, 57), Color("#F6B73C"), 4.0)

func draw_ellipse(center: Vector2, radii: Vector2, color: Color) -> void:
	var points := PackedVector2Array()
	for i in range(32):
		var angle := TAU * float(i) / 32.0
		points.append(center + Vector2(cos(angle) * radii.x, sin(angle) * radii.y))
	draw_colored_polygon(points, color)