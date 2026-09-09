extends Control

const CharacterArtScene = preload("res://character_art.gd")
const SAVE_PATH := "user://pati_patni_progress.json"
const SETTINGS_PATH := "user://pati_patni_settings.cfg"
const CUSTOM_FONT_PATH := "res://fonts/NotoSansDevanagari-Regular.ttf"

const BG := Color("#181530")
const PANEL := Color("#272044")
const PANEL_LIGHT := Color("#342956")
const CREAM := Color("#FFF8EA")
const MUTED := Color("#C4BBD8")
const YELLOW := Color("#F6B73C")
const PINK := Color("#E65D76")
const PURPLE := Color("#5A58C9")
const GREEN := Color("#63D29B")
const RED := Color("#F07070")

var levels := [
	{
		"title": "देर से घर",
		"english": "Late Home",
		"question": "पत्नी: आज इतनी देर से घर क्यों आए?",
		"answers": [
			{"text": "ट्रैफिक बहुत था।", "kind": "good", "mood": 10, "points": 100, "reply": "पत्नी: चलो, इस बार ट्रैफिक को माफ किया।"},
			{"text": "दोस्तों के साथ था।", "kind": "bad", "mood": -19, "points": -50, "reply": "पत्नी: दोस्त तुम्हारे घर का टाइमटेबल हैं क्या?"},
			{"text": "आपके लिए सरप्राइज़ लेने गया था।", "kind": "funny", "mood": 18, "points": 150, "reply": "पत्नी: सरप्राइज़ अच्छा है, पर अगली बार मैसेज भी कर देना।"}
		]
	},
	{
		"title": "मोबाइल फोन",
		"english": "Mobile Phone",
		"question": "पति: तुम मेरा फोन क्यों देख रही हो?",
		"answers": [
			{"text": "क्योंकि आपका फोन मुझसे ज़्यादा चमकता है।", "kind": "funny", "mood": 18, "points": 150, "reply": "पति: अच्छा, तो आज से चार्जर भी शेयर करेंगे।"},
			{"text": "बस ऐसे ही।", "kind": "bad", "mood": -21, "points": -50, "reply": "पति: यह 'बस ऐसे ही' बहुत रहस्यमय है।"},
			{"text": "आपका अलार्म बंद करने आई थी।", "kind": "good", "mood": 9, "points": 100, "reply": "पति: और मेरा राज़? वह भी बंद कर दो।"}
		]
	},
	{
		"title": "शॉपिंग",
		"english": "Shopping",
		"question": "पत्नी: ये कुशन इतने सारे क्यों हैं?",
		"answers": [
			{"text": "हर कुशन का अपना भावनात्मक सपोर्ट है।", "kind": "funny", "mood": 18, "points": 150, "reply": "पत्नी: तो फिर सोफे को भी धन्यवाद बोलो।"},
			{"text": "सेल में मिल रहे थे।", "kind": "good", "mood": 8, "points": 100, "reply": "पत्नी: ठीक है, आज तुम सेल में बच गए।"},
			{"text": "पता नहीं, आपने ही लिए होंगे।", "kind": "bad", "mood": -22, "points": -50, "reply": "पत्नी: अब तुम्हें भी कुशन की तरह कोने में रख दूँ?"}
		]
	},
	{
		"title": "सैलरी",
		"english": "Salary",
		"question": "पत्नी: सैलरी आते ही कहाँ गायब हो गई?",
		"answers": [
			{"text": "बजट में छुप गई, खोज अभियान चल रहा है।", "kind": "funny", "mood": 19, "points": 150, "reply": "पत्नी: अभियान में मैं भी शामिल हूँ।"},
			{"text": "बिल और किराए ने बुला लिया था।", "kind": "good", "mood": 10, "points": 100, "reply": "पत्नी: चलो, खर्चों ने कम से कम धन्यवाद तो कहा।"},
			{"text": "ये राज़ है।", "kind": "bad", "mood": -25, "points": -50, "reply": "पत्नी: अच्छा, फिर अगली चाय भी राज़ में ही मिलेगी।"}
		]
	},
	{
		"title": "चाय",
		"english": "Tea",
		"question": "पति: चाय में चीनी इतनी कम क्यों है?",
		"answers": [
			{"text": "आपकी मीठी बातें बैलेंस कर रही हूँ।", "kind": "funny", "mood": 18, "points": 150, "reply": "पति: तो आज मैं ही चाय हूँ?"},
			{"text": "डॉक्टर ने कम बोला था।", "kind": "good", "mood": 9, "points": 100, "reply": "पति: डॉक्टर ने मुस्कुराने को भी बोला था।"},
			{"text": "खुद डाल लो।", "kind": "bad", "mood": -20, "points": -50, "reply": "पति: चीनी तो डाल लूँगा, पर प्यार कहाँ से लाऊँ?"}
		]
	},
	{
		"title": "डिनर",
		"english": "Dinner",
		"question": "पत्नी: आज खाने में क्या बनाऊँ?",
		"answers": [
			{"text": "जो आपका दिल करे, मैं सब्ज़ी काट दूँगा।", "kind": "good", "mood": 12, "points": 100, "reply": "पत्नी: यह हुई न पार्टनर वाली बात।"},
			{"text": "कुछ भी।", "kind": "bad", "mood": -24, "points": -50, "reply": "पत्नी: फिर आज 'कुछ भी' ही प्लेट में आएगा।"},
			{"text": "आपकी मुस्कान के साथ दो गरम रोटियाँ।", "kind": "funny", "mood": 20, "points": 150, "reply": "पत्नी: मक्खन लगाना आता है, जवाब देना भी सीख गए!"}
		]
	},
	{
		"title": "टीवी रिमोट",
		"english": "TV Remote",
		"question": "पति: रिमोट कहाँ है? मैच शुरू होने वाला है!",
		"answers": [
			{"text": "रिमोट वहीं है जहाँ कल मोज़े मिले थे।", "kind": "funny", "mood": 17, "points": 150, "reply": "पति: घर में खज़ाने का नक्शा भी बनाना पड़ेगा।"},
			{"text": "पहले मेरा सीरियल, फिर आपका मैच।", "kind": "good", "mood": 9, "points": 100, "reply": "पति: समझौता मंज़ूर, पर ओवर मिस नहीं होना चाहिए।"},
			{"text": "रिमोट तो आपके हाथ में है।", "kind": "bad", "mood": -23, "points": -50, "reply": "पति: ओह। यह बात कैमरे पर रिकॉर्ड मत करना।"}
		]
	},
	{
		"title": "जन्मदिन भूल गए",
		"english": "Birthday Forgotten",
		"question": "पत्नी: तुम्हें आज का दिन याद है?",
		"answers": [
			{"text": "इतना याद है कि केक ने भी छुट्टी ली है।", "kind": "bad", "mood": -28, "points": -50, "reply": "पत्नी: अब मोमबत्ती तुम बुझाओगे, अकेले।"},
			{"text": "याद है, सरप्राइज़ की एक्टिंग कर रहा था।", "kind": "funny", "mood": 16, "points": 150, "reply": "पत्नी: एक्टिंग अच्छी थी, अब गिफ्ट दिखाओ।"},
			{"text": "हमारी सालगिरह! और आज का पूरा दिन आपका है।", "kind": "good", "mood": 14, "points": 100, "reply": "पत्नी: अब बात बनी, सेल्फी भी बनेगी।"}
		]
	},
	{
		"title": "दोस्तों की पार्टी",
		"english": "Friends",
		"question": "पति: दोस्तों ने अचानक पार्टी रख दी है।",
		"answers": [
			{"text": "जाइए, मैं भी अपनी सहेलियों को अचानक बुला लूँगी।", "kind": "funny", "mood": 16, "points": 150, "reply": "पति: पार्टी फैमिली पैक हो गई!"},
			{"text": "ठीक है, बस समय से वापस आना।", "kind": "good", "mood": 10, "points": 100, "reply": "पति: पक्का, आज दोस्त भी टाइमर लगाएंगे।"},
			{"text": "आपको जो करना है करो।", "kind": "bad", "mood": -24, "points": -50, "reply": "पति: यह 'करो' सुनकर पैर अपने आप रुक गए।"}
		]
	},
	{
		"title": "बात सुनी ही नहीं",
		"english": "You Never Listen",
		"question": "पत्नी: तुमने मेरी बात सुनी ही नहीं!",
		"answers": [
			{"text": "सुनी थी, दिमाग ने सेव करने में देर कर दी।", "kind": "funny", "mood": 18, "points": 150, "reply": "पत्नी: अब रिवाइंड करके पूरी बात सुनाओ।"},
			{"text": "माफ़ कीजिए, दोबारा बताइए, इस बार ध्यान से सुनूँगा।", "kind": "good", "mood": 13, "points": 100, "reply": "पत्नी: यही जवाब पहले देना था।"},
			{"text": "आपने कहा ही कब था?", "kind": "bad", "mood": -27, "points": -50, "reply": "पत्नी: अभी कहा, और अब तुम सुनोगे भी।"}
		]
	}
]

var content: Control
var splash_active := true
var current_level := 0
var mood := 55
var score := 0
var total_score := 0
var unlocked_level := 1
var best_scores: Array = []
var music_enabled := true
var sound_enabled := true
var game_paused := false
var answer_locked := false

var husband: CharacterArt
var wife: CharacterArt
var mood_bar: ProgressBar
var score_label: Label
var feedback_label: Label
var continue_button: Button
var answer_buttons: Array[Button] = []
var pause_overlay: Control
var music_timer: Timer
var audio_player: AudioStreamPlayer
var custom_font: Font

func _ready() -> void:
	load_saved_state()
	load_optional_font()
	build_shell()
	build_splash()
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	music_timer = Timer.new()
	music_timer.wait_time = 4.0
	music_timer.timeout.connect(_on_music_timer)
	add_child(music_timer)
	if music_enabled:
		music_timer.start()

func build_shell() -> void:
	var background := ColorRect.new()
	background.color = BG
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	content = Control.new()
	content.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(content)

func load_optional_font() -> void:
	if ResourceLoader.exists(CUSTOM_FONT_PATH):
		custom_font = load(CUSTOM_FONT_PATH) as Font

func apply_font(control: Control) -> void:
	if custom_font != null:
		control.add_theme_font_override("font", custom_font)

func clear_screen() -> void:
	game_paused = false
	pause_overlay = null
	for child in content.get_children():
		child.free()

func build_splash() -> void:
	clear_screen()
	splash_active = true
	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	content.add_child(center)
	var box := VBoxContainer.new()
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 14)
	center.add_child(box)
	var logo := Label.new()
	logo.text = "♥"
	logo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	logo.add_theme_font_size_override("font_size", 92)
	logo.add_theme_color_override("font_color", PINK)
	box.add_child(logo)
	var title := make_label("पति पत्नी की लड़ाई", 38, CREAM)
	box.add_child(title)
	var subtitle := make_label("हँसी वाली बहस में सही जवाब चुनिए", 18, MUTED)
	box.add_child(subtitle)
	var hint := make_label("टैप करके शुरू करें", 16, YELLOW)
	hint.modulate.a = 0.0
	box.add_child(hint)
	var tween := create_tween().set_loops()
	tween.tween_property(hint, "modulate:a", 1.0, 0.7)
	tween.tween_property(hint, "modulate:a", 0.35, 0.7)
	var start_timer := get_tree().create_timer(1.6)
	start_timer.timeout.connect(func() -> void:
		if splash_active:
			show_main_menu()
	)

func _input(event: InputEvent) -> void:
	if not splash_active:
		return
	if event is InputEventScreenTouch and event.pressed:
		show_main_menu()
	elif event is InputEventMouseButton and event.pressed:
		show_main_menu()

func show_main_menu() -> void:
	splash_active = false
	clear_screen()
	add_top_brand(content, "पति पत्नी की लड़ाई", "घर की बहस, आपकी समझदारी")
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_CENTER)
	center.position = Vector2(20, 205)
	center.size = Vector2(500, 620)
	content.add_child(center)
	var box := VBoxContainer.new()
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 15)
	center.add_child(box)
	var hero := make_panel(PANEL_LIGHT)
	hero.custom_minimum_size = Vector2(0, 130)
	box.add_child(hero)
	var hero_box := VBoxContainer.new()
	hero_box.alignment = BoxContainer.ALIGNMENT_CENTER
	hero.add_child(hero_box)
	hero_box.add_child(make_label("आज का मूड?", 27, CREAM))
	hero_box.add_child(make_label("प्यार बढ़ाइए, गुस्सा घटाइए!", 18, YELLOW))
	var start := make_button("▶  गेम शुरू करें", 64, PURPLE)
	start.pressed.connect(func() -> void: start_level(0))
	box.add_child(start)
	var levels_btn := make_button("▦  लेवल चुनें", 60, PANEL_LIGHT)
	levels_btn.pressed.connect(show_level_select)
	box.add_child(levels_btn)
	var settings := make_button("⚙  सेटिंग्स", 56, PANEL_LIGHT)
	settings.pressed.connect(show_settings)
	box.add_child(settings)
	var about := make_button("ⓘ  हमारे बारे में", 56, PANEL_LIGHT)
	about.pressed.connect(show_about)
	box.add_child(about)
	var saved := make_label("लेवल %d तक खुला है  •  कुल स्कोर %d" % [unlocked_level, total_score], 15, MUTED)
	box.add_child(saved)

func show_level_select() -> void:
	splash_active = false
	clear_screen()
	add_top_brand(content, "लेवल चुनें", "हर जवाब के साथ चुनौती बढ़ेगी")
	var back := make_small_button("‹  वापस")
	back.position = Vector2(24, 112)
	back.pressed.connect(show_main_menu)
	content.add_child(back)
	var scroll := ScrollContainer.new()
	scroll.position = Vector2(22, 190)
	scroll.size = Vector2(496, 665)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	content.add_child(scroll)
	var grid := GridContainer.new()
	grid.columns = 2
	grid.add_theme_constant_override("h_separation", 14)
	grid.add_theme_constant_override("v_separation", 14)
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(grid)
	for i in range(levels.size()):
		var level_data: Dictionary = levels[i]
		var is_open := i < unlocked_level
		var button := make_button("%s\n%s%s" % [
			("✓  " if is_open else "🔒  "), level_data["title"],
			("\nलेवल %d" % (i + 1))
		], 118, PURPLE if is_open else Color("#39344D"))
		button.custom_minimum_size = Vector2(238, 118)
		button.disabled = not is_open
		button.add_theme_font_size_override("font_size", 19)
		if is_open:
			var selected_level := i
			button.pressed.connect(func() -> void: start_level(selected_level))
		grid.add_child(button)

func start_level(level_index: int) -> void:
	current_level = clampi(level_index, 0, levels.size() - 1)
	score = 0
	mood = 55
	answer_locked = false
	game_paused = false
	show_gameplay()
	play_tone("click")

func show_gameplay() -> void:
	splash_active = false
	clear_screen()
	var data: Dictionary = levels[current_level]
	var page := VBoxContainer.new()
	page.position = Vector2(22, 20)
	page.size = Vector2(496, 920)
	page.add_theme_constant_override("separation", 10)
	content.add_child(page)

	var header := HBoxContainer.new()
	header.custom_minimum_size = Vector2(0, 58)
	page.add_child(header)
	var level_text := make_label("लेवल %d  ·  %s" % [current_level + 1, data["title"]], 22, CREAM)
	level_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	level_text.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	header.add_child(level_text)
	var pause := make_small_button("Ⅱ")
	pause.custom_minimum_size = Vector2(58, 52)
	pause.pressed.connect(toggle_pause)
	header.add_child(pause)

	var scene_panel := make_panel(PANEL)
	scene_panel.custom_minimum_size = Vector2(0, 274)
	page.add_child(scene_panel)
	var characters := HBoxContainer.new()
	characters.alignment = BoxContainer.ALIGNMENT_CENTER
	characters.add_theme_constant_override("separation", 8)
	scene_panel.add_child(characters)
	husband = CharacterArtScene.new()
	husband.set_character("husband", "confused")
	husband.custom_minimum_size = Vector2(220, 255)
	characters.add_child(husband)
	var divider := make_label("VS", 18, YELLOW)
	divider.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	characters.add_child(divider)
	wife = CharacterArtScene.new()
	wife.set_character("wife", "angry")
	wife.custom_minimum_size = Vector2(220, 255)
	characters.add_child(wife)

	var question_panel := make_panel(PANEL_LIGHT)
	question_panel.custom_minimum_size = Vector2(0, 94)
	page.add_child(question_panel)
	var question_box := VBoxContainer.new()
	question_box.alignment = BoxContainer.ALIGNMENT_CENTER
	question_panel.add_child(question_box)
	question_box.add_child(make_label(data["question"], 22, CREAM))
	question_box.add_child(make_label("सही जवाब सोचकर चुनिए...", 15, MUTED))

	var mood_header := HBoxContainer.new()
	mood_header.custom_minimum_size = Vector2(0, 32)
	page.add_child(mood_header)
	var mood_title := make_label("मूड मीटर", 17, CREAM)
	mood_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	mood_header.add_child(mood_title)
	score_label = make_label("स्कोर  %d" % score, 17, YELLOW)
	mood_header.add_child(score_label)
	mood_bar = ProgressBar.new()
	mood_bar.max_value = 100
	mood_bar.value = mood
	mood_bar.show_percentage = false
	mood_bar.custom_minimum_size = Vector2(0, 25)
	mood_bar.add_theme_stylebox_override("background", style_box(Color("#3A263E"), 12, 0))
	mood_bar.add_theme_stylebox_override("fill", style_box(GREEN, 12, 0))
	page.add_child(mood_bar)
	var meter_hint := make_label("😡  गुस्सा  ←  संतुलन  →  खुश  ♥", 14, MUTED)
	page.add_child(meter_hint)

	var answers_title := make_label("आप क्या जवाब देंगे?", 19, CREAM)
	page.add_child(answers_title)
	var answer_box := VBoxContainer.new()
	answer_box.add_theme_constant_override("separation", 8)
	answer_box.size_flags_vertical = Control.SIZE_EXPAND_FILL
	page.add_child(answer_box)
	answer_buttons.clear()
	var answers: Array = data["answers"]
	for i in range(answers.size()):
		var answer_data: Dictionary = answers[i]
		var button := make_button("%d.  %s" % [i + 1, answer_data["text"]], 58, PANEL_LIGHT)
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.add_theme_font_size_override("font_size", 18)
		var selected_answer := i
		button.pressed.connect(func() -> void: choose_answer(selected_answer))
		answer_box.add_child(button)
		answer_buttons.append(button)
	feedback_label = make_label("", 16, YELLOW)
	feedback_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	feedback_label.custom_minimum_size = Vector2(0, 40)
	feedback_label.visible = false
	page.add_child(feedback_label)
	continue_button = make_button("आगे बढ़ें  ›", 56, PURPLE)
	continue_button.visible = false
	continue_button.pressed.connect(finish_level)
	page.add_child(continue_button)

func choose_answer(answer_index: int) -> void:
	if answer_locked or game_paused:
		return
	answer_locked = true
	var answer_data: Dictionary = levels[current_level]["answers"][answer_index]
	mood = clampi(mood + int(answer_data["mood"]), 0, 100)
	score += int(answer_data["points"])
	total_score = max(0, total_score + int(answer_data["points"]))
	for button in answer_buttons:
		button.disabled = true
	score_label.text = "स्कोर  %d" % score
	mood_bar.value = mood
	var kind: String = answer_data["kind"]
	if kind == "bad":
		wife.set_character("wife", "angry")
		husband.set_character("husband", "confused")
		wife.shake()
		husband.shake()
		play_tone("wrong")
		feedback_label.add_theme_color_override("font_color", RED)
	elif kind == "funny":
		wife.set_character("wife", "laughing")
		husband.set_character("husband", "laughing")
		wife.celebrate()
		husband.celebrate()
		play_tone("funny")
		feedback_label.add_theme_color_override("font_color", YELLOW)
	else:
		wife.set_character("wife", "happy")
		husband.set_character("husband", "happy")
		wife.celebrate()
		husband.celebrate()
		play_tone("correct")
		feedback_label.add_theme_color_override("font_color", GREEN)
	feedback_label.text = answer_data["reply"]
	feedback_label.visible = true
	continue_button.text = "रिज़ल्ट देखें  ›"
	continue_button.visible = true

func finish_level() -> void:
	if not answer_locked:
		return
	var bonus := 200
	if mood >= 80:
		bonus += 150
	elif mood >= 60:
		bonus += 75
	score += bonus
	total_score = max(0, total_score + bonus)
	unlocked_level = max(unlocked_level, min(levels.size(), current_level + 2))
	record_best_score()
	save_progress()
	play_tone("complete")
	show_result()

func show_result() -> void:
	clear_screen()
	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	content.add_child(center)
	var box := VBoxContainer.new()
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 13)
	center.add_child(box)
	var emoji := "♥" if mood >= 70 else ("😊" if mood >= 45 else "😵")
	box.add_child(make_label(emoji, 68, YELLOW if mood >= 45 else RED))
	box.add_child(make_label("लेवल पूरा!", 34, CREAM))
	box.add_child(make_label(levels[current_level]["title"], 19, MUTED))
	var result_panel := make_panel(PANEL_LIGHT)
	result_panel.custom_minimum_size = Vector2(430, 190)
	box.add_child(result_panel)
	var stats := VBoxContainer.new()
	stats.alignment = BoxContainer.ALIGNMENT_CENTER
	result_panel.add_child(stats)
	stats.add_child(make_label("स्कोर  %d" % score, 27, YELLOW))
	stats.add_child(make_label("मूड  %d%%  %s" % [mood, "खुश" if mood >= 70 else "ठीक-ठाक"], 21, GREEN if mood >= 55 else RED))
	var stars := 1
	if mood >= 60:
		stars = 2
	if mood >= 80:
		stars = 3
	stats.add_child(make_label("★".repeat(stars) + "☆".repeat(3 - stars), 31, YELLOW))
	stats.add_child(make_label("लेवल बोनस शामिल है", 15, MUTED))
	if current_level < levels.size() - 1:
		var next := make_button("अगला लेवल  ›", 58, PURPLE)
		next.pressed.connect(func() -> void: start_level(current_level + 1))
		box.add_child(next)
	var replay := make_button("फिर से खेलें", 54, PANEL_LIGHT)
	replay.pressed.connect(func() -> void: start_level(current_level))
	box.add_child(replay)
	var levels_btn := make_button("लेवल चुनें", 54, PANEL_LIGHT)
	levels_btn.pressed.connect(show_level_select)
	box.add_child(levels_btn)
	var home := make_small_button("मुख्य मेनू")
	home.pressed.connect(show_main_menu)
	box.add_child(home)

func toggle_pause() -> void:
	if pause_overlay != null:
		return
	game_paused = true
	pause_overlay = ColorRect.new()
	pause_overlay.color = Color(0.04, 0.02, 0.10, 0.86)
	pause_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	pause_overlay.z_index = 20
	content.add_child(pause_overlay)
	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	pause_overlay.add_child(center)
	var box := VBoxContainer.new()
	box.custom_minimum_size = Vector2(360, 270)
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 14)
	center.add_child(box)
	box.add_child(make_label("गेम रुका है", 30, CREAM))
	var resume := make_button("▶  जारी रखें", 58, PURPLE)
	resume.pressed.connect(resume_game)
	box.add_child(resume)
	var restart := make_button("फिर से शुरू करें", 54, PANEL_LIGHT)
	restart.pressed.connect(func() -> void: start_level(current_level))
	box.add_child(restart)
	var quit := make_button("लेवल छोड़ें", 54, PANEL_LIGHT)
	quit.pressed.connect(show_main_menu)
	box.add_child(quit)

func resume_game() -> void:
	if pause_overlay != null:
		pause_overlay.free()
		pause_overlay = null
	game_paused = false
	play_tone("click")

func show_settings() -> void:
	clear_screen()
	add_top_brand(content, "सेटिंग्स", "आपके फोन में ही सुरक्षित रहता है")
	var back := make_small_button("‹  वापस")
	back.position = Vector2(24, 112)
	back.pressed.connect(show_main_menu)
	content.add_child(back)
	var center := CenterContainer.new()
	center.position = Vector2(20, 200)
	center.size = Vector2(500, 500)
	content.add_child(center)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 16)
	center.add_child(box)
	var panel := make_panel(PANEL)
	panel.custom_minimum_size = Vector2(0, 180)
	box.add_child(panel)
	var options := VBoxContainer.new()
	options.add_theme_constant_override("separation", 15)
	panel.add_child(options)
	var music := CheckButton.new()
	music.text = "♫  संगीत"
	music.button_pressed = music_enabled
	music.add_theme_font_size_override("font_size", 22)
	music.add_theme_color_override("font_color", CREAM)
	music.toggled.connect(func(value: bool) -> void:
		music_enabled = value
		save_settings()
		if value:
			music_timer.start()
		else:
			music_timer.stop()
		play_tone("click")
	)
	options.add_child(music)
	var sound := CheckButton.new()
	sound.text = "♪  ध्वनि प्रभाव"
	sound.button_pressed = sound_enabled
	sound.add_theme_font_size_override("font_size", 22)
	sound.add_theme_color_override("font_color", CREAM)
	sound.toggled.connect(func(value: bool) -> void:
		sound_enabled = value
		save_settings()
		if value:
			play_tone("click")
	)
	options.add_child(sound)
	box.add_child(make_label("बदलाव अपने आप सेव हो जाते हैं।", 16, MUTED))
	var reset := make_button("प्रगति रीसेट करें", 56, Color("#55304E"))
	reset.pressed.connect(reset_progress)
	box.add_child(reset)

func reset_progress() -> void:
	unlocked_level = 1
	total_score = 0
	best_scores.clear()
	save_progress()
	play_tone("wrong")
	show_settings()

func show_about() -> void:
	clear_screen()
	add_top_brand(content, "हमारे बारे में", "यह गेम हँसी के लिए बनाया गया है")
	var back := make_small_button("‹  वापस")
	back.position = Vector2(24, 112)
	back.pressed.connect(show_main_menu)
	content.add_child(back)
	var scroll := ScrollContainer.new()
	scroll.position = Vector2(24, 190)
	scroll.size = Vector2(492, 610)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	content.add_child(scroll)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 15)
	scroll.add_child(box)
	var panel := make_panel(PANEL)
	box.add_child(panel)
	var copy := make_label(
		"पति पत्नी की लड़ाई एक परिवार के साथ खेलने वाला छोटा सा हिंदी गेम है।\n\n" +
		"यहाँ कोई असली लड़ाई नहीं—सिर्फ़ मज़ेदार जवाब, प्यार और थोड़ी-सी नोकझोंक है।\n\n" +
		"सभी किरदार और चित्र इस गेम के लिए मौलिक हैं। गेम ऑफलाइन चलता है और आपकी प्रगति फोन पर ही सेव होती है।",
		18, CREAM
	)
	copy.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	copy.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	panel.add_child(copy)
	box.add_child(make_label("संस्करण 1.0  •  Godot 4.x  •  शुभ खेल!", 15, MUTED))

func add_top_brand(parent: Control, title: String, subtitle: String) -> void:
	var box := VBoxContainer.new()
	box.position = Vector2(24, 28)
	box.size = Vector2(492, 105)
	box.add_theme_constant_override("separation", 4)
	parent.add_child(box)
	var title_label := make_label(title, 32, CREAM)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(title_label)
	var subtitle_label := make_label(subtitle, 16, MUTED)
	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(subtitle_label)

func make_label(text_value: String, font_size: int, color: Color) -> Label:
	var label := Label.new()
	label.text = text_value
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.25))
	label.add_theme_constant_override("shadow_offset_x", 1)
	label.add_theme_constant_override("shadow_offset_y", 2)
	apply_font(label)
	return label

func make_button(text_value: String, height: int, color: Color) -> Button:
	var button := Button.new()
	button.text = text_value
	button.custom_minimum_size = Vector2(0, height)
	button.add_theme_font_size_override("font_size", 21)
	button.add_theme_color_override("font_color", CREAM)
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_color_override("font_pressed_color", Color.WHITE)
	button.add_theme_stylebox_override("normal", style_box(color, 17, 0))
	button.add_theme_stylebox_override("hover", style_box(color.lightened(0.12), 17, 2, YELLOW))
	button.add_theme_stylebox_override("pressed", style_box(color.darkened(0.1), 17, 2, YELLOW))
	button.add_theme_stylebox_override("disabled", style_box(Color("#39344D"), 17, 0))
	button.add_theme_color_override("font_disabled_color", Color("#817991"))
	apply_font(button)
	return button

func make_small_button(text_value: String) -> Button:
	var button := make_button(text_value, 48, PANEL_LIGHT)
	button.add_theme_font_size_override("font_size", 17)
	return button

func make_panel(color: Color) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", style_box(color, 20, 1, Color(1, 1, 1, 0.06)))
	return panel

func style_box(color: Color, radius: int, border_width: int = 0, border_color: Color = Color.TRANSPARENT) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.corner_radius_top_left = radius
	box.corner_radius_top_right = radius
	box.corner_radius_bottom_left = radius
	box.corner_radius_bottom_right = radius
	box.border_width_left = border_width
	box.border_width_top = border_width
	box.border_width_right = border_width
	box.border_width_bottom = border_width
	box.border_color = border_color
	box.content_margin_left = 18
	box.content_margin_right = 18
	box.content_margin_top = 10
	box.content_margin_bottom = 10
	return box

func record_best_score() -> void:
	while best_scores.size() <= current_level:
		best_scores.append(0)
	if score > int(best_scores[current_level]):
		best_scores[current_level] = score

func load_saved_state() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var parsed = JSON.parse_string(FileAccess.get_file_as_string(SAVE_PATH))
		if parsed is Dictionary:
			unlocked_level = clampi(int(parsed.get("unlocked_level", 1)), 1, levels.size())
			total_score = int(parsed.get("total_score", 0))
			var saved_scores = parsed.get("best_scores", [])
			if saved_scores is Array:
				best_scores = saved_scores
	if FileAccess.file_exists(SETTINGS_PATH):
		var config := ConfigFile.new()
		if config.load(SETTINGS_PATH) == OK:
			music_enabled = bool(config.get_value("audio", "music", true))
			sound_enabled = bool(config.get_value("audio", "sound", true))

func save_progress() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file != null:
		file.store_string(JSON.stringify({
			"unlocked_level": unlocked_level,
			"total_score": total_score,
			"best_scores": best_scores
		}))

func save_settings() -> void:
	var config := ConfigFile.new()
	config.set_value("audio", "music", music_enabled)
	config.set_value("audio", "sound", sound_enabled)
	config.save(SETTINGS_PATH)

func _on_music_timer() -> void:
	if music_enabled:
		play_tone("music", true)

func play_tone(kind: String, is_music: bool = false) -> void:
	if is_music:
		if not music_enabled:
			return
	elif not sound_enabled:
		return
	var frequency := 420.0
	var duration := 0.12
	var volume := 0.10
	match kind:
		"correct":
			frequency = 680.0
			duration = 0.18
			volume = 0.16
		"funny":
			frequency = 520.0
			duration = 0.22
			volume = 0.15
		"wrong":
			frequency = 180.0
			duration = 0.24
			volume = 0.14
		"complete":
			frequency = 760.0
			duration = 0.34
			volume = 0.15
		"music":
			frequency = 260.0
			duration = 0.45
			volume = 0.035
		"click":
			frequency = 440.0
			duration = 0.07
			volume = 0.08
	var generator := AudioStreamGenerator.new()
	generator.mix_rate = 44100
	generator.buffer_length = max(0.5, duration + 0.05)
	audio_player.stream = generator
	audio_player.play()
	var playback := audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames := int(generator.mix_rate * duration)
	for i in range(frames):
		var envelope := 1.0 - float(i) / float(frames)
		var sample := sin(PI * 2.0 * frequency * float(i) / generator.mix_rate) * envelope * volume
		playback.push_frame(Vector2(sample, sample))