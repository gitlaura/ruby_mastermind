require_relative 'lib/runner.rb'

class Interface
	def self.get_interface
		puts "\nWhere would you like to play mastermind?\n1)Command Line\n2)Web\nPlease select a numeric option:"
		selection = gets.chomp.to_i
	end
end

selection = Interface.get_interface

if selection == 1
	runner = Runner.new
	runner.play_game
else
	puts "\n**Please go to localhost:4567 to play Mastermind!**\n\n"

	require 'sinatra'

	GlobalVariables = {}
	GlobalVariables[:secret_code] = nil
	GlobalVariables[:guesses] = []

	get '/' do
		erb :home
	end

	post '/' do
		unless params[:secret_code].nil?
			GlobalVariables[:secret_code] = params[:secret_code]
			@secret_code_message = "Nice job! Secret code is set."
		end

		unless params[:guess].nil?
			@guess = params[:guess]
			UIWeb.get_result(@guess, GlobalVariables[:secret_code])
			@black = UIWeb.black
			@white = UIWeb.white
			GlobalVariables[:guesses] << [@guess, @black, @white]
			@guess_one, @black_one, @white_one = 				GlobalVariables[:guesses][0][0], GlobalVariables[:guesses][0][1], GlobalVariables[:guesses][0][2]
			@guess_two, @black_two, @white_two = 				GlobalVariables[:guesses][1][0], GlobalVariables[:guesses][1][1], GlobalVariables[:guesses][1][2] unless GlobalVariables[:guesses].size < 2
			@guess_three, @black_three, @white_three = 	GlobalVariables[:guesses][2][0], GlobalVariables[:guesses][2][1], GlobalVariables[:guesses][2][2] unless GlobalVariables[:guesses].size < 3
			@guess_four, @black_four, @white_four = 		GlobalVariables[:guesses][3][0], GlobalVariables[:guesses][3][1], GlobalVariables[:guesses][3][2] unless GlobalVariables[:guesses].size < 4
			@guess_five, @black_five, @white_five = 		GlobalVariables[:guesses][4][0], GlobalVariables[:guesses][4][1], GlobalVariables[:guesses][4][2] unless GlobalVariables[:guesses].size < 5
			@guess_six, @black_six, @white_six = 				GlobalVariables[:guesses][5][0], GlobalVariables[:guesses][5][1], GlobalVariables[:guesses][5][2] unless GlobalVariables[:guesses].size < 6
			@guess_seven, @black_seven, @white_seven = 	GlobalVariables[:guesses][6][0], GlobalVariables[:guesses][6][1], GlobalVariables[:guesses][6][2] unless GlobalVariables[:guesses].size < 7
			@guess_eight, @black_eight, @white_eight = 	GlobalVariables[:guesses][7][0], GlobalVariables[:guesses][7][1], GlobalVariables[:guesses][7][2] unless GlobalVariables[:guesses].size < 8
			@guess_nine, @black_nine, @white_nine = 		GlobalVariables[:guesses][8][0], GlobalVariables[:guesses][8][1], GlobalVariables[:guesses][8][2] unless GlobalVariables[:guesses].size < 9
			@guess_ten, @black_ten, @white_ten = 				GlobalVariables[:guesses][9][0], GlobalVariables[:guesses][9][1], GlobalVariables[:guesses][9][2] unless GlobalVariables[:guesses].size < 10
		end

		erb :home
	end
end