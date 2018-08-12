require './helper'
require 'yaml'
module Hangman
	class Game
		
		private

		attr_accessor :secret_word, :dictionary, :bad_letters, :hints, :line_count

		public

		def initialize
			@dictionary = "../5desk.txt"
			@line_count = File.foreach(dictionary).reduce(0){ |lines, _| lines + 1 }
			@secret_word = select_word
			@bad_letters = []
			@hints = secret_word.gsub(/[A-Z]/, "_").split("")
			#p @secret_word
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
			show_hints
			loop do				
				break if !player_turn
				show_hints
				break if game_over?
			end
		end

		def show_mechanics
			puts "Guess the secret word. Input only one letter at a time for your guesses to count."
			puts "Otherwise, type 'SAVE' if you want to save and exit your game anytime."
			puts "Alternatively, type 'QUIT' or 'EXIT' if you just want to exit your game."
			puts "Good luck!"
		end

		def show_hints	
			puts		
			puts hints.join(" ")
			puts

			if !bad_letters.empty?
				print "wrong guesses: "
				puts bad_letters.join(", ")
				puts
			end
		end

		def player_turn
			commands = ["SAVE", "EXIT", "QUIT"]
			loop do
				puts "#{6 - bad_letters.size} lives remaining."
				print "input: "
				guess = gets.chomp.upcase
				save_game if guess == "SAVE"
				return false if commands.include?(guess)
				break if commands.include?(guess) || evaluate(guess)
			end
			true
		end

		def evaluate(guess)			
			#invalid
			return false if guess.size > 1 || !guess.between?("A", "Z") ||
				bad_letters.include?(guess) || hints.include?(guess)		
			
			#matched
			matched_indices = secret_word.select_indices { |i| secret_word[i] == guess }
			hints.map!.with_index { |item, i| matched_indices.include?(i) ? guess : item }

			#no match			
			bad_letters << guess if matched_indices.empty?
			true
		end

		def save_game
			save_folder = "../save"
			Dir.mkdir(save_folder) if !Dir.exists?(save_folder)
			File.open(save_folder + "/game.yml", "w") { |file| file.write(self.to_yaml) }
		end

		def game_over?
			if !hints.include?("_")
				puts "Congratulations! You guessed the secret word!"
				return true
			elsif bad_letters.size > 5
				puts "Sorry, you are out of turns. The secret word is '#{secret_word}'"
				return true
			end
			false
		end
	end
end