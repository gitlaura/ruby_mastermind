require_relative 'validity.rb'
require_relative 'web_main.rb'
require 'sinatra/base'

class SinatraApp < Sinatra::Base
	include Validity

	get '/' do
		erb :code_maker
	end

	post '/' do
		web_main = WebMain.new 

		if params[:code_maker] == "1"
			erb :secret_code

		elsif params[:code_maker] == "2"
			code_maker = params[:code_maker].to_i
			@secret_code = web_main.get_secret_code(code_maker)
			@display_message = web_main.display_secret_code_message
			erb :guesser

		elsif params[:guesser] == "1"
				@secret_code = params[:secret_code]
				@guesses = []
				erb :make_guess

		elsif params[:guesser] == "2"
			@secret_code = params[:secret_code]
			guesser = params[:guesser].to_i
			@guesses = web_main.get_guesses(guesser, @secret_code)
			@display_message = web_main.end_game(@guesses)
			erb :show_guesses

		elsif params[:new_guess]
			new_guess = params[:new_guess].upcase
			@secret_code = params[:secret_code]
			if valid_combination?(new_guess)
				@guesses = web_main.create_array_of_guesses(@secret_code, params)
				if web_main.game_over?([@guesses.last[1],@guesses.last[2]],@guesses.size + 1)
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

		elsif params[:secret_code]
			@secret_code = params[:secret_code].upcase
			if valid_combination?(@secret_code)
				@display_message = web_main.display_secret_code_message
				erb :guesser
			else
				@display_message = web_main.invalid_selection_message
				erb :secret_code
			end
		end

	end
end