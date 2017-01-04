require './hangman'

def show_menu
	puts "Welcome to Hangman!"
	puts
	puts "[1] New Game"
	puts "[2] Load Game"
	puts "[3] Exit"
	print "input: "		
end

def continue?
	print "Go back to the title screen? (Y to confirm) : "
	false if gets.chomp.upcase != "Y"
end

show_menu
input =	gets.chomp.to_i

game = nil
case input
when 1
	game = Hangman::Game.new
when 2
	game = YAML::load_file('../save/game.yml')
	#show list of saved game files
	#user selects saved game
	#load game
end

game.play if !game.nil?