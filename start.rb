require_relative 'lib/main.rb'
require_relative 'lib/runner.rb'

class Interface
	def self.get_interface
		puts "\nWhere would you like to play mastermind?\n1)Command Line\n2)Web\nPlease select a numeric option:"
		return selection = gets.chomp.to_i 
		return selection if selection == 1 || selection == 2
		puts "Oops, try again!"
		self.get_interface
	end
end

selection = Interface.get_interface

if selection == 1
	runner = Runner.new
	runner.play_game
else
	puts "\n**Please go to localhost:4567 to play Mastermind!**\n\n"

	require 'sinatra'

	CodeMaker = nil
	Guesser = nil
	SecretCode = nil
	Guesses = []
	Game = []

	get '/' do
		erb :home
	end

	post '/' do
		unless params[:code_maker].nil?
			Game = Main.new
			CodeMaker = params[:code_maker]
			@display_message = "Awesome! Player 1 is set."
			if CodeMaker == "2"
				player = Game.players[CodeMaker.to_i - 1]
				Game.code_maker = player
				SecretCode = Game.get_secret_code
				@display_message = "Awesome! Player 1 set the secret code."
			end
		end

		unless params[:secret_code].nil?
			SecretCode = params[:secret_code]
			@display_message = "Nice job! Secret code is set."
		end

		unless params[:guesser].nil?
			Guesser = params[:guesser]
			@display_message = "Great! Now, player 2 is set."
			if Guesser == "2"
				player = Game.players[CodeMaker.to_i - 1]
				Game.guesser = player
				scores = [0,0]
				counter = 1
				@display_message = nil
				until @display_message != nil
					guess = Game.get_guess(counter)
					scores = Game.check_guess(guess, SecretCode)
					black, white = scores.first, scores.last
					Guesses << {:guess => guess, :black => black, :white => white}
					@display_message = "Player #2 wins! The secret code was #{SecretCode}. lease restart at the command line to play again." if black == 4
					@display_message = "Game over! Player 1 wins." if Guesses.size >= 10 && black < 4
					counter += 1
				end
			end
		end

		unless params[:guess].nil?
			guess = params[:guess]
			scores = Game.check_guess(guess, SecretCode)
			black, white = scores.first, scores.last
			Guesses << {:guess => guess, :black => black, :white => white}
			@display_message = "Good guess! Player #2 wins! Please restart at the command line to play again." if black == 4
			@display_message = "Game over! Player 1 wins." if Guesses.size >= 10 && black < 4
		end

		erb :home
	end
end