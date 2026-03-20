extends Control

signal close_window()
signal log_text(text: String, clr: bool)

@export var chattext: Array[Dictionary] = []
var cur_mes: int = 0

var nameToImg: Dictionary[String, Resource] = {
	"hajime": preload("res://textures/hajime.png"),
	"nagito": preload("res://textures/nagito from deviantart.png"),
	"*": null
}

func set_text():
	print(chattext[cur_mes])
	#$VBoxContainer/RichTextLabel.clear()
	#$VBoxContainer/RichTextLabel.append_text(
		#"[font_size='45']["+chattext[cur_mes].name+"][/font_size]\n")
	#$VBoxContainer/RichTextLabel.append_text(
		#"[font_size='30']"+chattext[cur_mes].text+"[/font_size]"
	#)
	emit_signal("log_text", 
	"[font_size='20'][color='green']["+chattext[cur_mes].name+"][/color]:"+chattext[cur_mes].text+"[/font_size]"
	, true)
	$TextureRect.texture = nameToImg[chattext[cur_mes].name]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var par = get_parent()
	if par:
		print(par.name)
		par.connect("send_chat", _on_send_chat)
	if chattext.size() > 0:
		set_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		cur_mes += 1
		if cur_mes < chattext.size():
			set_text()
		else:
			emit_signal("close_window")

func _on_send_chat(x: Array):
	print("got chat")
	chattext = []
	cur_mes = 0
	for i in x:
		var text: String = i[1]
		chattext.append({"name":i[0],"text":text})
		#var full_text = []
		#var chunk_len = 50
		#full_text.append(text.substr(0, chunk_len))
		#for t in range(1,(text.length() / chunk_len)+1):
			#var text2 = text.substr(t * chunk_len,chunk_len)
			#if text2.length() > 0:
				#full_text.append(text2)
			
		#for t in full_text:
			#chattext.append({"name":i[0],"text":t})
	set_text()
