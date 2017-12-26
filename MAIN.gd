extends Control

var credential = null

func _ready():
	get_node("Admin Pass/Password").grab_focus()
	get_node("Admin Pass/Password").connect("text_entered", self, "check")
	self.connect("mouse_enter", self, "f")
	


func check(text):
	var cred
	if text == "jv":
		cred = 1
		get_node("Admin Pass").hide()
		evm()
	elif text == "sv":
		cred = 1.5
		get_node("Admin Pass").hide()
		evm()
	elif text == "tc":
		cred = 2
		get_node("Admin Pass").hide()
		evm()
	elif text == "pc":
		cred = 5
		get_node("Admin Pass").hide()
		evm()
	elif text == "exit":
		self.hide()
		self.queue_free()
		return
	elif text == "exitevm":
		get_tree().quit()
		return
	else:
		cred = -1
	credential = cred
	get_node("School Captain/Label").set_text(String(credential))
	get_node("House Captain/Label").set_text(String(credential))
	get_node("House_Vice_Captain/Label").set_text(String(credential))
	get_node("Admin Pass/Password").clear()
	

func evm():
	get_node("House_Vice_Captain").show()
	get_node("House Captain").show()
	get_node("School Captain").show()
	get_node("Admin Pass").show()
	
func f():
	get_node("Admin Pass/Password").grab_focus()