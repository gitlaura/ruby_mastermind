require_relative 'message_center.rb'
require_relative 'computer_player.rb'
require_relative 'guess_checker.rb'
require_relative 'validity.rb'

class Main
	include Validity

	COLORS = ["R", "Y", "G", "B", "P", "O"]

	def initialize
		computer_player = ComputerPlayer.new(COLORS)
		@players = [computer_player]
	end

	def get_secret_code(code_maker)
		player = @players[code_maker - 1]
		player.select_secret_code
	end

	def get_guesses(guesser, secret_code, is_command_line = false)
		counter, scores, guesses = 1, [], []
		until game_over?(scores, counter)
			guess = get_guess(guesser, scores.first, scores.last, guess)
			scores = check_guess(guess,secret_code)
			guesses <<  [guess, scores.first, scores.last]
			display_scores(guesses.last, counter) if is_command_line
			counter += 1
		end
		guesses
	end

	def get_guess(guesser, black, white, guess)
		player = @players[guesser - 1]
		player.get_guess(black, white, guess)
	end

	def check_guess(guess, secret_code)
		GuessChecker.check_guess(guess, secret_code, COLORS)
	end

	def game_over?(scores, counter)
		return true if scores == four_correct_guesses
		return true if counter > guess_limit
		false
	end

	def secret_code_message
		MessageCenter.secret_code_message
	end

	def invalid_selection_message
		MessageCenter.invalid_selection_message
	end

	def game_over_message(guesses)
		final_scores = [guesses.last[1], guesses.last[2]]
		if final_scores == four_correct_guesses
			MessageCenter.player_two_wins_message
		else 
			MessageCenter.player_one_wins_message
		end
	end

	private

	def four_correct_guesses
		[4,0]
	end

	def guess_limit
		10
	end
end