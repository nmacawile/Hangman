module Hangman
	class Game

		attr_accessor :dictionary

		private

		attr_accessor :secret_word

		public

		def initialize
			@dictionary = "../5desk.txt"
			@secret_word = select_word
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

		def line_count
			@count ||= File.foreach(dictionary).reduce(0){ |line_count, _| line_count + 1 }
		end
	end
end