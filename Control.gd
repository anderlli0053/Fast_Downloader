# What built-in class does this script extend

extends Control

# Universal use of HTTPRequest
onready var dlreq = get_node("http requests/HTTPRequest") as HTTPRequest


# Download URLs
const vscode_url = str("https://az764295.vo.msecnd.net/stable/e7d7e9a9348e6a8cc8c03f877d39cb72e5dfb1ff/VSCodeUserSetup-x64-1.60.0.exe")






# Ready method that runs only once in scene tree when the program is executed / opened

func _ready():

	VisualServer.texture_set_shrink_all_x2_on_set_data(true)


	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


# Theme initialization and loading
var green_theme := preload('res://green.res') as Theme
var solarized_theme := preload('res://dark_solarized.res') as Theme




# Theme changing button

func _on_CheckButton_toggled(button_pressed: bool) -> void:

	if button_pressed == false:
		self.set_theme(green_theme)

	elif button_pressed == true:
		self.set_theme(solarized_theme)

	else:
		print("Unknown error occured!")


# Quit
func _on_quit_exit_pressed() -> void:
	get_tree().quit()


# VSCODE functions

func _on_download_vscode_pressed() -> void:

	dlreq.download_file = current_dir + "Downloaded Software" + "vscode_installer.exe"
	dlreq.use_threads = true
	dlreq.request(vscode_url)


# File variables (creation)
var current_dir = OS.get_executable_path()
var dir = Directory.new()


func Make_directory():

	if !dir.dir_exists(current_dir + "Downloaded Software"):

		dir.make_dir(current_dir + "Downloaded Software")

	elif dir.dir_exists(current_dir + "Downloaded Software"):

		print("Directory already exists... skipping the creation...")

	else:
		print("Unknown error occured!")

