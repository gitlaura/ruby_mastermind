require_relative '../game/validity.rb'
require_relative 'web_main.rb'
require 'sinatra/base'

class SinatraApp < Sinatra::Base
	include Validity

	attr_reader :secret_code

	get '/' do
		erb :code_maker
	end

	get '/guesser' do
		web_main = WebMain.new
		@secret_code = web_main.get_secret_code(2)
		@display_message = web_main.display_secret_code_message
		erb :guesser
	end

	get '/secret_code' do 
		@display_message = WebMain.new.invalid_selection_message
		erb :secret_code
	end

	get '/computer_guesses' do 
		web_main = WebMain.new 
		@guesses = web_main.get_guesses(2, params[:secret_code])
		@display_message = web_main.end_game(@guesses)
		erb :show_guesses
	end

	post '/secret_code' do
		if params[:code_maker] == "1"
			erb :secret_code
		else
			redirect '/guesser' 
		end
	end

	post '/guesser' do
		@secret_code = params[:secret_code].upcase
		if valid_combination?(@secret_code)
			@display_message = WebMain.new.display_secret_code_message
			erb :guesser
		else
			redirect '/secret_code'
		end
	end

	post '/guessone' do 
		if params[:guesser] == "1"
			@secret_code = params[:secret_code]
			@guesses = []
			erb :make_guess
		else
			redirect '/computer_guesses?secret_code=' + params[:secret_code]
		end
	end

	post '/makeguess' do
		web_main = WebMain.new
		@secret_code = params[:secret_code]
		if valid_combination?(params[:new_guess])
			@guesses = web_main.create_array_of_guesses(@secret_code, params)
			if web_main.game_over?(@guesses.last[1..2],@guesses.size + 1)
				@display_message = web_main.end_game(@guesses)
				erb :show_guesses
			else
				erb :make_guess
			end
		else
			@guesses = web_main.create_array_of_guesses(@secret_code, params, false)
			@display_message = web_main.invalid_selection_message
			erb :make_guess
		end
	end
end