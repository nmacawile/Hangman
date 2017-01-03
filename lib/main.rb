require './hangman'
module Hangman

	def show_menu
		puts "Welcome to Hangman!"
		puts
		puts "[1] New Game"
		puts "[2] Load Game"
		puts "[3] Exit"
		print "input: "		
	end

	#show_menu
	input = 1#gets.chomp.to_i

	game = nil
	case input
		when 1
			game = Game.new
			game.play
		when 2
			#show list of saved game files
			#user selects saved game
			#load game
		else
			#close
	end
end