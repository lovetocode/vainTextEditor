extends Control
var app_name = "Vain text editor"
var current_file = "Untitled"

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_window_title()
	$FileMenuButton.get_popup().connect("id_pressed", self, "_on_item_file_pressed")
	$HelpMenuButton.get_popup().connect("id_pressed", self, "_on_item_help_pressed")
	
func _update_window_title():
	OS.set_window_title(app_name + " - " + current_file)
	
func new_file():
	current_file = "Untitled"
	_update_window_title()
	$TextEdit.text = ""
	
func save_file():
	var path = current_file
	if path == "Untitled":
		$SaveFileDialog.popup()
	else:
		_on_SaveFileDialog_file_selected(path)
		
func _on_SaveFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, 2)
	f.store_string($TextEdit.text)
	f.close()
	_update_window_title()

func _on_OpenFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, 1)
	$TextEdit.text = f.get_as_text()
	f.close()
	current_file = path
	_update_window_title()

func _on_item_file_pressed(id):
	var item_name = $FileMenuButton.get_popup().get_item_text(id)
	if item_name == "New File": 
		new_file()
	elif item_name == "Open":
		$OpenFileDialog.popup()
	elif item_name == "Save":
		save_file()
	elif item_name == "Save As":
		$SaveFileDialog.popup()
	elif item_name == "Quit":
		get_tree().quit()
		
func _on_item_help_pressed(id):
	var item_name = $HelpMenuButton.get_popup().get_item_text(id)
	if item_name == "About": 
		$About.popup()

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open("https:www.twitter.com/computerfan")
