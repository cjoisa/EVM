extends Container

var key = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]

var hc1_name = null
var hc1_score = 0
var hc2_name = null
var hc2_score = 0

var hvc1_name = null
var hvc1_score = 0
var hvc2_name = null
var hvc2_score = 0

var count = 0
var count1
var count2
var count3

func _ready():
	init()
	#get_node("LineEdit").grab_focus()
	get_node("START").connect("pressed", self, "_pressed")
	get_node("LineEdit").connect("text_entered", self, "check")
	get_node("WindowDialog/ok").connect("pressed", self, "ok")
	get_node("WindowDialog/exit").connect("pressed", self, "_exit")
	get_node("EXIT").connect("pressed", self, "_exit")
	get_node("ERROR/exit").connect("pressed", self, "_exit")
	pass


func _pressed():
	var scene = load("res://MAIN.tscn")
	var node = scene.instance()
	add_child(node)
	pass

func check(text):
	var c1_name
	var c1_score = 10
	var c2_name
	var c2_score = 10
	if text == "brigade":
		c1_name = null
		c1_score = 0
		c2_name = null
		c2_score = 0
		var ifile = File.new()
		ifile.open_encrypted("scpt.evm", ifile.READ, key)
		c1_name = ifile.get_line()
		c1_score = ifile.get_double()
		c2_name = ifile.get_line()
		c2_score = ifile.get_double()
		count1 = ifile.get_double()
		ifile.close()
		ifile.open_encrypted("hcpt.evm", ifile.READ, key)
		hc1_name = ifile.get_line()
		hc1_score = ifile.get_double()
		hc2_name = ifile.get_line()
		hc2_score = ifile.get_double()
		count2 = ifile.get_double()
		ifile.close()
		ifile.open_encrypted("vcpt.evm", ifile.READ, key)
		hvc1_name = ifile.get_line()
		hvc1_score = ifile.get_double()
		hvc2_name = ifile.get_line()
		hvc2_score = ifile.get_double()
		count3 = ifile.get_double()
		ifile.close()
		display(c1_name, c1_score, c2_name, c2_score)
		
		
	elif text == "reset":
		var file = File.new()
		file.open("SCHOOL_CAPTAIN.txt", file.READ)
		c1_name = file.get_line()
		c2_name = file.get_line()
		file.close()
		file.open_encrypted("scpt.evm", file.WRITE, key)
		file.store_line(c1_name)
		file.store_double(0)
		file.store_line(c2_name)
		file.store_double(0)
		file.store_double(0)
		file.close()
		file.open("HOUSE_CAPTAIN.txt", file.READ)
		c1_name = file.get_line()
		c2_name = file.get_line()
		file.close()
		file.open_encrypted("hcpt.evm", file.WRITE, key)
		file.store_line(c1_name)
		file.store_double(0)
		file.store_line(c2_name)
		file.store_double(0)
		file.store_double(0)
		file.close()
		file.open("HOUSE_VICE_CAPTAIN.txt", file.READ)
		c1_name = file.get_line()
		c2_name = file.get_line()
		file.close()
		file.open_encrypted("vcpt.evm", file.WRITE, key)
		file.store_line(c1_name)
		file.store_double(0)
		file.store_line(c2_name)
		file.store_double(0)
		file.store_double(0)
		file.close()
	get_node("LineEdit").clear()

func display(c1_name, c1_score, c2_name, c2_score):
	if count1 != count2 && count2 != count3:
		get_node("ERROR").show()
	else: count = count1
	
	get_node("WindowDialog/Number/VOTERS").set_text(String(count))
	
	get_node("WindowDialog").popup()
	get_node("WindowDialog/Candidate1_name").set_text(c1_name)
	get_node("WindowDialog/Candidate1_score").set_text(String(c1_score))
	get_node("WindowDialog/Candidate2_name").set_text(c2_name)
	get_node("WindowDialog/Candidate2_score").set_text(String(c2_score))
	
	get_node("WindowDialog/HCandidate1_name").set_text(hc1_name)
	get_node("WindowDialog/HCandidate1_score").set_text(String(hc1_score))
	get_node("WindowDialog/HCandidate2_name").set_text(hc2_name)
	get_node("WindowDialog/HCandidate2_score").set_text(String(hc2_score))
	
	get_node("WindowDialog/HVCandidate1_name").set_text(hvc1_name)
	get_node("WindowDialog/HVCandidate1_score").set_text(String(hvc1_score))
	get_node("WindowDialog/HVCandidate2_name").set_text(hvc2_name)
	get_node("WindowDialog/HVCandidate2_score").set_text(String(hvc2_score))
	pass

func ok():
	get_node("WindowDialog").hide()

func _exit():
	get_tree().quit()
	

func init():
	var f = File.new()
	if f.open("SCHOOL_CAPTAIN.txt", f.READ) != 0:
		get_node("ERROR").show()
	elif f.open("HOUSE_CAPTAIN.txt", f.READ) != 0:
		get_node("ERROR").show()
	elif f.open("HOUSE_VICE_CAPTAIN.txt", f.READ) != 0:
		get_node("ERROR").show()
	elif f.open_encrypted("scpt.evm", f.READ, key) != 0:
		get_node("ERROR").show()
	elif f.open_encrypted("hcpt.evm", f.READ, key) != 0:
		get_node("ERROR").show()
	elif f.open_encrypted("vcpt.evm", f.READ, key) != 0:
		get_node("ERROR").show()
