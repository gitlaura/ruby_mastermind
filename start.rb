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

	get '/' do
		erb :home,	:locals => {:code_maker => @code_maker, :secret_code => @secret_code, :guesser => @guesser, :guesses => @guesses}
	end

	post '/' do
		@code_maker = params[:code_maker]
		@secret_code = params[:secret_code]
		@guesser = params[:guesser]
		@guesses = params[:guesses]

		if !@code_maker.nil? && @secret_code.nil? && @guesser.nil? && @guesses.nil?
			web_runner = WebRunner.new
			@code_maker = params[:code_maker].to_i
			if @code_maker == 2
				@secret_code = web_runner.get_secret_code(@code_maker)
				@display_message = "Awesome! Player 1 set the secret code."
			end
		end

		if @code_maker == "1" && !@secret_code.nil? && @guesser.nil? && @guesses.nil?
			@secret_code = params[:secret_code].upcase
			if valid_combination?(@secret_code)
				@display_message = "Nice job! Secret code is set."
			else
				@display_message = "Not a valid code. Try again!"
			end
		end

		if !@code_maker.nil? && !@secret_code.nil? && !@guesser.nil? && @guesses.nil?
			web_runner = WebRunner.new
			@guesser = params[:guesser].to_i
			if @guesser == 2
				@guesses = web_runner.get_guesses(@guesser, @secret_code)
				@display_message = "The secret code was #{@secret_code}. Player #2 wins! Please restart at the command line to play again."
			end
		end

		if @guesser == "1" && !params[:guess].nil?
			web_runner = WebRunner.new
			guess = params[:guess].upcase
			if @guesses.empty?
				@guesses = []
			end
			if valid_combination?(guess)
				scores = web_runner.check_guess(guess, @secret_code)
				@guesses = web_runner.add_guess(guess, scores, @guesses)
				@display_message = "Game over! The secret code was #{@secret_code}. Player 1 wins. Please restart at the command line to play again." if @guesses.size == 10
				@display_message = "Good guess! Player #2 wins! Please restart at the command line to play again." if @guesses.last[1] == 4
			else
				@display_message = "Not a valid guess. Try again!"
			end
		end

		erb :home, :locals => {:code_maker => @code_maker, :secret_code => @secret_code, :guesser => @guesser, :guesses => @guesses}
	end
end