extends Node

var can1_name
var can1_score 
var can2_name
var can2_score 

var credential


var count = 0
var c = 0

func _ready():
	var file = File.new()
	file.open("SCHOOL_CAPTAIN.txt", file.READ)
	can1_name = file.get_line()
	can2_name = file.get_line()
	file.close()
	get_node("Background/Candidate 1").connect("pressed", self, "_pressed")
	get_node("Background/Candidate 2").connect("pressed", self, "__pressed")
	hcpt()
	pass
	


func _pressed():
	add_cpt(1)
	hcpt()
	pass

func __pressed():
	add_cpt(2)
	hcpt()
	pass

func add_cpt(choice):
	var file = File.new()
	var key = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]
	file.open_encrypted("scpt.evm", file.READ, key)
	file.get_line()
	can1_score = file.get_double()
	file.get_line()
	can2_score = file.get_double()
	count = file.get_double()
	file.close()
	credential = float(get_node("Label").get_text())
	if choice == 1:
		can1_score += credential
	else:
		can2_score += credential
	count += 1
	file.open_encrypted("scpt.evm", file.WRITE, key)
	file.store_line(can1_name)
	file.store_double(can1_score)
	file.store_line(can2_name)
	file.store_double(can2_score)
	file.store_double(count)
	file.close()
	file.open("scp.evm", file.WRITE)
	file.store_line(can1_name)
	file.store_double(can1_score)
	file.store_line(can2_name)
	file.store_double(can2_score)
	file.store_double(count)
	file.close()

func hcpt():
	if c > 0:
		self.hide()
	else:
		c += 1
		get_node("Background/TextureFrame").show()