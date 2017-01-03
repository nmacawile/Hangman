module Hangman
	class Game

		attr_accessor :dictionary, :bad_letters, :good_letters, :hints

		private

		attr_accessor :secret_word

		public

		def initialize
			@dictionary = "../5desk.txt"
			@secret_word = select_word
			@bad_letters = []
			@good_letters = []
			@hints = secret_word.gsub(/[A-Z]/, "_").split("")
					p @secret_word
		end

		def line_count
			@count ||= File.foreach(dictionary).reduce(0){ |line_count, _| line_count + 1 }
		end

		def select_word			
			selected_word = nil
			while selected_word.nil?
				selected_index = rand(0...line_count)
				File.foreach(dictionary).each_with_index do |curr_word, curr_index|
					if curr_index == selected_index and curr_word.chomp.size.between?(5, 12)
						selected_word = curr_word.chomp.upcase
					end
				end
			end
			selected_word
		end

		def play
			show_mechanics
			#loop until the word is guessed or the player reached bad guess limit
			loop do
				show_hints
				player_turn
				break if !hints.include?("_")
			end
			#check game conditions
			#end loop
		end

		def show_mechanics
			puts "Guess the secret word one letter at a time."
		end

		def show_hints
			
			puts hints.join(" ")
			puts bad_letters.join(", ")
		end

		def player_turn
			print "guess: "
			puts hints.join(" ")
			guess = gets.chomp.upcase
			matched_indices = secret_word.split("").each_index.select { |i| secret_word[i] == guess }
			hints.each_index { |i| hints[i] = guess if matched_indices.include?(i) }
			p matched_indices
			puts hints.join(" ")
		end		
	end
end