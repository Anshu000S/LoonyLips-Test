extends Control

var player_words=[]

var template = []

var current_story={}


onready var DisplayText= $VBoxContainer/DisplayText
onready var PlayerText= $VBoxContainer/HBoxContainer/PlayerText

func _ready():
	set_current_story()
	DisplayText.text="Welcome to LoonyLips. We are going to tell a story.We will have so much fun! "
	check_player_word_length()
	PlayerText.grab_focus()
	
	
func set_current_story():
	randomize()
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts 
	current_story.story = $StoryBook.get_child(selected_story).story	


func _on_PlayerText_text_entered(new_text):
	add_to_players_words()
	
	
func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:	
		add_to_players_words()
	
	
	
func add_to_players_words():
	player_words.append(PlayerText.text)
	DisplayText.text=""
	PlayerText.clear()
	check_player_word_length()
	
	
func is_story_done():
	return player_words.size() == current_story.prompts.size()
	
	
func check_player_word_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		
		
func tell_story():
	DisplayText.text= current_story.story % player_words
	
func prompt_player():
	DisplayText.text+="May I have a " + current_story.prompts[player_words.size()] +" please?"
			
			
func end_game():
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text="Again!"
	tell_story() 
