require_relative 'Validity.rb'
require 'sinatra/base'
include Validity

class SinatraApp < Sinatra::Base

	get '/' do
		erb :home
	end

	post '/' do
		if params[:code_maker] > 0
			@code_maker = params[:code_maker].to_i
			if @code_maker == 2
				web_runner = WebRunner.new
				@secret_code = web_runner.get_secret_code(@code_maker)
				@display_message = "Awesome! Player 1 set the secret code."
				erb :guesser
			elsif 
				erb :secret_code
			end
		elsif !params[:secret_code].nil?
			@secret_code = params[:secret_code].upcase
			if valid_combination?(@secret_code)
				@display_message = "Nice job! Secret code is set."
				erb :guesser
			else
				@display_message = "Not a valid code. Try again!"
				erb :secret_code
			end
		elsif !params[:guesser].nil?
			guesser = params[:guesser].to_i
			@secret_code = params[:secret_code]
			if guesser == 2
				web_runner = WebRunner.new
				@guesses = web_runner.get_guesses(guesser, @secret_code)
				@display_message = "The secret code was #{@secret_code}. Player #2 wins! Please restart at the command line to play again."
				erb :show_guessses
			else
				erb :make_guess
			end
		elsif !params[:guess].nil?
			guess = params[:guess].upcase
			@guess_number = params[:guess_number].to_i
			@secret_code = params[:secret_code]
			if valid_combination?(guess)
				scores = web_runner.check_guess(guess, @secret_code)
				"guess_#{@guess_number}".to_sym = guess
				"black_#{@guess_number}".to_sym = scores.first
				"white_#{@guess_number}".to_sym = scores.last
				@guess_number += 1
				@display_message = "Game over! The secret code was #{@secret_code}. Player 1 wins. Please restart at the command line to play again." if @guess_number == 11
				@display_message = "Good guess! Player #2 wins! Please restart at the command line to play again." if "black_#{@guess_number}".to_sym == 4
			else
				@display_message = "Not a valid guess. Try again!"
			end
			erb :make_guess
		end
	end
end