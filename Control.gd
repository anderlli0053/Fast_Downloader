#		Written by Andrew (Andrej) Poženel AKA SloDevTeam - 2020-2021		#

# What built-in class does this script extend

extends Control

# Universal use of HTTPRequest
onready var htr_dlreq_npp = $"http requests/npp" as HTTPRequest
onready var htr_dlreq_vscode = $"http requests/vscode"




# Onready variable for the label
onready var ostype_lbl = $Panel/ostype

# onready variable for progress bar class
onready var pb = $"progress bar/ProgressBar"




var bodySize1 = get_node("http requests/npp").get_body_size()
var downloadedBytes1 = get_node("http requests/npp").get_downloaded_bytes()

var bodySize2 = get_node("http requests/vscode").get_body_size()
var downloadedBytes2 = get_node("http requests/vscode").get_downloaded_bytes()



# shadowed variant/variable for returning the name of the current system the method/function is executed on..
var sys = OS.get_name()



# I changed from constants to variables/variants in favor to easier re-edit the links in the editor, also made them exportable for that matter #

# const vscode_url = str("https://az764295.vo.msecnd.net/stable/e7d7e9a9348e6a8cc8c03f877d39cb72e5dfb1ff/VSCodeUserSetup-x64-1.60.0.exe")

# const npp_url = str("https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.4/npp.8.1.4.Installer.x64.exe")
###


# Download URLs

export var vscode_url = str("https://az764295.vo.msecnd.net/stable/e7d7e9a9348e6a8cc8c03f877d39cb72e5dfb1ff/VSCodeUserSetup-x64-1.60.0.exe")

export var npp_url = str("https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.1.4/npp.8.1.4.Installer.x64.exe")







# Ready method that runs only once in scene tree when the program is executed / opened

func _ready():

	VisualServer.texture_set_shrink_all_x2_on_set_data(true)

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	set_process(false)


	#DetectOS()







	#Make_directory()


# Theme initialization and loading
var green_theme := preload('res://green.res') as Theme
var solarized_theme := preload('res://dark_solarized.res') as Theme





# Quit
func _on_quit_exit_pressed() -> void:
	get_tree().quit()


# VSCODE functions

func _on_download_vscode_pressed() -> void:

	#Make_directory()

	set_process(true)

	var new_http_req1 : HTTPRequest = HTTPRequest.new() as HTTPRequest


#	htr_dlreq_vscode.download_file = user_dir + "vscode_installer.exe"
#	htr_dlreq_vscode.use_threads = true
#	htr_dlreq_vscode.request(vscode_url)

	new_http_req1.download_file = user_dir + "vscode_installer.exe"
	new_http_req1.use_threads = true
	new_http_req1.request(vscode_url)

# Managing the download progress and showing it via progress bar
	var bodySize = new_http_req1.get_body_size()
	var downloadedBytes = new_http_req1.get_downloaded_bytes()
	var percent = int(downloadedBytes*100/bodySize)
	$"progress bar/ProgressBar".value = percent






func _on_download_npp_pressed() -> void:

	#Make_directory()


# Managing the download progress and showing it via progress bar

	set_process(true)

	var new_http_req2 : HTTPRequest = HTTPRequest.new() as HTTPRequest

#	htr_dlreq_npp.download_file = user_dir + "npp_installer.exe"
#	htr_dlreq_npp.use_threads = true
#	htr_dlreq_npp.request(npp_url)

	new_http_req2.download_file = user_dir + "npp_installer.exe"
	new_http_req2.use_threads = true
	new_http_req2.request(npp_url)

	var bodySize = new_http_req2.get_body_size()
	var downloadedBytes = new_http_req2.get_downloaded_bytes()
	var percent = int(downloadedBytes*100/bodySize)
	$"progress bar/ProgressBar".value = percent







# File variables (creation)
var current_dir = OS.get_executable_path()
var user_dir : String = "user://" as String
var dir = Directory.new()


#func Make_directory():
#
#	if !dir.dir_exists(user_dir +"/DownloadedSoftware"):
#
#		dir.make_dir(user_dir +"/DownloadedSoftware")
#
#	elif dir.dir_exists(user_dir +"/DownloadedSoftware"):
#
#		print("Directory already exists... skipping the creation...")
#
#	else:
#		print("Unknown error occured!")






func DetectOS():



	if OS.get_name() == "X11":
		print("You are using Linux-based OS, the execution will continue, but be warned that some apps listed here cannot run on Linux, because they are more or less Windows based!")
		print("Some of them can be emulated with WINE on Linux!")
	elif OS.get_name() == "Windows":
		print("You are using Windows OS")

	elif OS.get_name() != "X11" or "Windows":
		 print("ONLY WINDOWS OS AND LINUX BASED DISTROS ARE SUPPORTED.... BOTH PARTIALLY!")

	else:
		printerr("Unknown error occured while detecting OS type!")


	print("Detected OS: " + sys)





func _on_DetectOSType_pressed() -> void:

	DetectOS()

	ostype_lbl.text = sys
	ostype_lbl.bbcode_text = "[color=red]" + sys + "[/color]"





# Theme changing button

func _on_CheckButton_toggled(button_pressed: bool) -> void:

		if button_pressed == false:
			self.set_theme(green_theme)

		elif button_pressed == true:
			self.set_theme(solarized_theme)

		else:
			print("Unknown error occured!")



# Function that updates the progress bar accordingly to the download parameters, take in the "pb" variable argument
#
#func ProgressBarDownload(pb):
#
#	var bodySize = dlreq.get_body_size()
#	var downloadedBytes = dlreq.get_downloaded_bytes()
#
#	var percent = int(downloadedBytes*100/bodySize)
#	pb.value = percent
#	# print(str(percent) + " downloaded")


func _on_npp_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:

	print("Successfully downloaded NPP EXE INSTALLER with the following request data: ")
	print(" ")
	print(result)
	print(" ")
	print(response_code)
	print(" ")
	print(headers)
	print(" ")
	print(body)
	print(" ")

	set_process(false)


func _on_vscode_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:

	print("Successfully downloaded VSCODE EXE INSTALLER with the following request data: ")
	print(" ")
	print(result)
	print(" ")
	print(response_code)
	print(" ")
	print(headers)
	print(" ")
	print(body)
	print(" ")

	set_process(false)


# Process function that runs every frame

func _process(delta: float) -> void:


	var percent1 = int(downloadedBytes1*100/bodySize1)
	$"progress bar/ProgressBar".value = percent1



	var percent2 = int(downloadedBytes2*100/bodySize2)
	$"progress bar/ProgressBar".value = percent2



	pass
