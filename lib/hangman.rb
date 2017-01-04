require './helper'
require 'yaml'
module Hangman
	class Game

		attr_accessor :dictionary, :bad_letters, :hints, :line_count

		private

		attr_accessor :secret_word

		public

		def initialize
			@dictionary = "../5desk.txt"
			@line_count = File.foreach(dictionary).reduce(0){ |lines, _| lines + 1 }
			@secret_word = select_word
			@bad_letters = []
			@hints = secret_word.gsub(/[A-Z]/, "_").split("")
					p @secret_word
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
				player_turn
				show_hints
				break if game_over?
			end
		end

		def show_mechanics
			puts "Guess the secret word. Input only one letter at a time."
		end

		def show_hints	
			puts		
			puts hints.join(" ")
			puts
			print "wrong guesses: "
			puts bad_letters.empty? ? "none" : bad_letters.join(", ")
			puts
		end

		def player_turn
			loop do
				print "input: "
				guess = gets.chomp.upcase
				break if evaluate(guess)
			end		
		end

		def evaluate(guess)
			save_game if guess == "SAVE"
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
			Dir.mkdir("../save") if !Dir.exists?("../save")
			File.open("../save/game.yml", "w") { |file| a= file.write(self.to_yaml) ; puts a}
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