require_relative 'UI.rb'

class MessageCenter
	include UI

	attr_accessor :code_maker, :guesser

	def get_code_maker
		give("Player 1 will make the secret code. Please select a type of player:\n1) Human\n2) Computer")
		receive.to_i
	end

	def get_guesser
		give("Player 2 will try to guess the code in 10 tries. Please select a type of player:\n1) Human\n2) Computer")
		receive.to_i
	end

	def display_code_message
		give("Player 1: Created the secret code.")
	end

	def display_guess(guess)
		give("Player 2: Guessed #{guess}")
	end

	def display_results(black, white)
		give("Player 1: That guess gets #{black} black peg(s) and #{white} white peg(s).")
	end

	def goodbye(guess_counter)
		give("Game over! Player 2 wins in #{guess_counter} tries!")
	end

	def game_over
		give("Game over! Player 1 wins. Player 2 did not guess correctly in 10 tries.")
	end
end