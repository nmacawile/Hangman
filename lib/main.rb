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

def quit?
	print "Do you want to play again? (Y to confirm) : "
	gets.chomp.upcase == "Y" ? false : true
end

loop do
	show_menu
	input =	gets.chomp.to_i

	game = nil
	case input
	when 1
		game = Hangman::Game.new
	when 2
		save_file = "../save/game.yml"
		if File.exists?(save_file)
			game = YAML::load_file(save_file)
			File.delete(save_file)
		else
			puts "No saved game found. Creating a new game instead."
			game = Hangman::Game.new
		end
	end

	game.play if !game.nil?

	break if game.nil? || quit?

end