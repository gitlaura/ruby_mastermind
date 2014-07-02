require_relative 'UI.rb'
require_relative 'validity.rb'

class MessageCenter
	include UI
	include Validity

	attr_accessor :code_maker, :guesser

	def get_code_maker
		give("Player 1 will make the secret code. Please select a type of player:\n1) Human\n2) Computer")
		selection = receive.to_i
		return selection if valid_player?(selection)
		give("**Not a valid selection. Try again!**")
		get_code_maker
	end

	def get_guesser
		give("Player 2 will try to guess the code in 10 tries. Please select a type of player:\n1) Human\n2) Computer")
		selection = receive.to_i
		return selection if valid_player?(selection)
		give("**Not a valid selection. Try again!**")
		get_guesser
	end

	def display_code_message
		give("Player 1: Created the secret code.")
	end

	def display_guess(guess, guess_counter)
		give("Player 2: Guess ##{guess_counter} is #{guess}")
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