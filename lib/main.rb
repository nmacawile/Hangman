require './hangman'

def show_menu
	puts "Welcome to Hangman!"
	puts
	puts "[1] New Game"
	puts "[2] Load Game"
	puts "[3] Exit"
	puts
	print "input: "		
end

def main_menu?
	print "\nType 'Y' to go back to the main menu. : "
	gets.chomp.upcase == "Y" ? true : false
end

def play_again?
	print "\nDo you want to play again? (Y to play again): "
	gets.chomp.upcase == "Y" ? true : false
end

loop do
	show_menu
	input =	gets.chomp.to_i

	case input
	when 1
		Hangman::Game.new.play
	when 2
		save_file = "../save/game.yml"
		if File.exists?(save_file)
			YAML::load_file(save_file).play			
			File.delete(save_file)
		else
			puts "No saved game found. Creating a new game instead."
			puts
			Hangman::Game.new.play
		end
	else
		break
	end

		Hangman::Game.new.play
	end

	break if !main_menu?

end