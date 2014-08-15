require_relative '../game/validity.rb'
require_relative 'web_main.rb'
require 'sinatra/base'

class SinatraApp < Sinatra::Base
	include Validity

	use Rack::Session::Pool
	
	get '/' do
		session.clear
		set_main
		erb :code_maker
	end

	get '/secret_code' do
		@display_message = session[:message]
		erb :secret_code
	end

	get '/guesser' do
		@display_message = session[:message]
		erb :guesser
	end

	get '/guess' do
		@display_message = session[:message]
		@guesses = session[:guesses]
		erb :make_guess
	end

	get '/game_over' do
		@display_message = session[:message]
		@guesses = session[:guesses]
		erb :show_guesses
	end

	post '/code_maker' do
		if params[:code_maker] == computer_player
			get_code_from_computer_player 
			redirect '/guesser'
		else
			redirect '/secret_code'
		end
	end

	post '/secret_code' do
		secret_code = params[:secret_code].upcase
		if valid_combination?(secret_code)
			set_secret_code(secret_code)
			redirect '/guesser'
		else
			display_invalid_selection
			redirect '/secret_code'
		end
	end

	post '/guesser' do
		reset_message	 
		if params[:guesser] == computer_player
			get_guesses_from_computer_player
			end_game
		else
			set_guesses
			redirect '/guess'
		end
	end

	post '/newguess' do
		reset_message
		guess = params[:new_guess].upcase
		if valid_combination?(guess)
			set_human_guess(guess)
			end_game if game_over?
			redirect '/guess'
		else
			display_invalid_selection
			redirect '/guess'
		end
	end

	private

	def computer_player
		"2"
	end	

	def set_main
		session[:main] = WebMain.new
	end

	def main
		session[:main]
	end

	def set_secret_code(secret_code)
		session[:secret_code] = secret_code
		set_message(main.secret_code_message)
	end

	def set_guesses(guesses = [])
		session[:guesses] = guesses
	end

	def add_guess(guess)
		session[:guesses] << guess
	end

	def set_message(message)
		session[:message] = message
	end

	def reset_message
		session[:message].clear
	end

	def display_invalid_selection
		set_message(main.invalid_selection_message)
	end

	def get_code_from_computer_player
		set_secret_code(main.get_secret_code(computer_player.to_i))
	end

	def get_guesses_from_computer_player
		set_guesses(main.get_guesses(computer_player.to_i, session[:secret_code]))
	end

	def set_human_guess(guess)
		scores = main.check_guess(guess, session[:secret_code])
		add_guess([guess, scores.first, scores.last])
	end

	def game_over?
		final_scores = [session[:guesses].last[1], session[:guesses].last[2]]
		main.game_over?(final_scores, session[:guesses].size+1)
	end

	def end_game
		set_message(main.game_over_message(session[:guesses]))
		redirect '/game_over'
	end
end