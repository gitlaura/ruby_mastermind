require_relative 'lib/io_runner.rb'
require_relative 'lib/web_runner.rb'
require_relative 'lib/validity.rb'


class Interface
	def self.get_interface
		puts "\nWhere would you like to play mastermind?\n1)Command Line\n2)Web\nPlease select a numeric option:"
		selection = gets.chomp.to_i 
		return selection if selection == 1 || selection == 2
		puts "Oops, try again!"
		self.get_interface
	end
end

selection = Interface.get_interface

if selection == 1
	runner = IORunner.new
	runner.play_game
else
	puts "\n**Please go to localhost:4567 to play Mastermind!**\n\n"

	require 'sinatra'
	include Validity

	CodeMaker = nil
	SecretCode = nil
	Guesser = nil
	Guesses = []

	get '/' do
		erb :home
	end

	post '/' do
		unless params[:code_maker].nil?
			Runner = WebRunner.new
			CodeMaker = params[:code_maker].to_i
			if CodeMaker == 2
				SecretCode = Runner.get_secret_code(CodeMaker)
				@display_message = "Awesome! Player 1 set the secret code."
			end
		end

		unless params[:secret_code].nil?
			SecretCode = params[:secret_code].upcase
			if valid_combination?(SecretCode)
				@display_message = "Nice job! Secret code is set."
			else
				@display_message = "Not a valid code. Try again!"
			end
		end

		unless params[:guesser].nil?
			Guesser = params[:guesser].to_i
			if Guesser == 2
				Guesses = Runner.get_guesses(Guesser, SecretCode)
				@display_message = "The secret code was #{SecretCode}. Player #2 wins! Please restart at the command line to play again."
			end
		end

		unless params[:guess].nil?
			guess = params[:guess].upcase
			if valid_combination?(guess)
				scores = Runner.check_guess(guess, SecretCode)
				Guesses = Runner.add_guess(guess, scores)
				@display_message = "Game over! The secret code was #{SecretCode}. Player 1 wins. Please restart at the command line to play again." if Guesses.size == 10
				@display_message = "Good guess! Player #2 wins! Please restart at the command line to play again." if Guesses.last[:black] == 4
			else
				@display_message = "Not a valid guess. Try again!"
			end
		end

		erb :home
	end
end