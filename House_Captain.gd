
extends Control

var can1_name
var can1_score = 0
var can2_name
var can2_score = 0

var credential

var count = 0
var c = 0

func _ready():
	var file = File.new()
	file.open("HOUSE_CAPTAIN.txt", file.READ)
	can1_name = file.get_line()
	can2_name = file.get_line()
	file.close()
	get_node("Background/Candidate 1").connect("pressed", self, "_pressed")
	get_node("Background/Candidate 2").connect("pressed", self, "__pressed")
	hvcpt()
	pass


func _pressed():
	add_hcpt(1)
	hvcpt()
	pass

func __pressed():
	add_hcpt(2)
	hvcpt()
	pass

func add_hcpt(choice):
	var file = File.new()
	var key = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]
	file.open_encrypted("hcpt.evm", file.READ, key)
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
	file.open_encrypted("hcpt.evm", file.WRITE, key)
	file.store_line(can1_name)
	file.store_double(can1_score)
	file.store_line(can2_name)
	file.store_double(can2_score)
	file.store_double(count)
	file.close()
	file.open("hcp.evm", file.WRITE)
	file.store_line(can1_name)
	file.store_double(can1_score)
	file.store_line(can2_name)
	file.store_double(can2_score)
	file.store_double(count)
	file.close()

func hvcpt():
	if c > 0:
		self.hide()
		#self.queue_free()
	else:
		c += 1