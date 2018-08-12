require './hangman'

def get_input
	puts
	puts
	print "input: "
	gets.chomp
end

def main_menu_action
	puts "Welcome to Hangman!"
	puts
	puts "[1] New Game"
	puts "[2] Load Game"
	puts "[3] Exit"	
	input = get_input.to_i	
	evaluate_action(input)
end

def evaluate_action(input)
	case input
	when 1
		play_game
		true
	when 2
		try_to_load
		true
	else
		false
	end
end

def play_game
	Hangman::Game.new.play
end

def try_to_load
	save_file = "../save/game.yml"
	if File.exists?(save_file)
		YAML::load_file(save_file).play			
		File.delete(save_file)
	else
		puts "No saved game found. Creating a new game instead."
		puts
		play_game
	end
end

def play_again?
	print "\nDo you want to play again?"
	puts
	print "\nPress ENTER to play again or"
    print "\ntype 'N' to quit: "
	get_input.upcase == "N" ? false : true
end

def back_to_main_menu?
	print "\nPress ENTER to confirm quit or"
	print "\ntype 'M' to return to the main menu: "
    get_input.upcase == "M" ? true : false
end

loop do
	break if !main_menu_action

    play_game while play_again?

	break if !back_to_main_menu?
end