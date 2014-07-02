require_relative 'code_list.rb'


class ComputerPlayer
	attr_reader :code_list

	def initialize
		@code_list = CodeList.new
	end

	def select_secret_code
		@code_list.possibilities.sample
	end

	def get_guess(black, white, guess)
		@code_list.update_list(black, white, guess) unless guess.nil?
		@code_list.possibilities.sample
	end
end