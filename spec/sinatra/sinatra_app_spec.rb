require_relative '../../lib/sinatra/sinatra_app'
require 'rspec'
require 'rack/test'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    SinatraApp.new
  end

  describe "get /" do
		  it "displays code_maker page" do
				get '/'

				expect(last_response.body).to include("Player #1 will select the secret code. Which type of player would you like?")
			end
	end

	describe "get /guesser" do
		it "creates a secret code" do
			get '/guesser'

			expect(last_response.body).to include("Player 1 created the secret code.")
		end
	end

	describe "get /secret_code" do
		it "displays secret code error message" do
			get '/secret_code'

			expect(last_response.body).to include("Try again!")
		end
	end

	describe "get /computer_guesses" do
		it "displays computer guesses" do
			get '/computer_guesses', "secret_code" => "RRPP"

			expect(last_response.body).to include("Player 2's Guesses:")
		end
	end

	describe "post /secret_code" do 
		it "displays secret code page if code_maker is a human" do 
			post '/secret_code', :code_maker => "1"

			expect(last_response.body).to include{"Please select a secret code"}
		end

		it "redirects to /guesser if code_maker is a computer" do 
			post "/secret_code", :code_maker => "2"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/guesser')
		end
	end

	describe "post /guesser" do 
		it "displays guesser if secret code is valid" do 
			post '/guesser', :secret_code => 'RROO'

			expect(last_response.body).to include("Which type of player would you like?")
		end

		it "redirects to /secret_code if secret code is invalid" do 
			post '/guesser', :secret_code => 'RMOO'

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/secret_code')
		end
	end

	describe "post /guessone" do 
		it "displays make guess page if the guesser is human" do 
			post '/guessone', :guesser => "1", :secret_code => "RRRR"

			expect(last_response.body).to include("Player 2: Please make guesses until you get 4 black pegs.")
		end

		it "redirects to computer_guesses if guesser is computer" do
		 	post '/guessone', :guesser => "2", :secret_code => "RRRR"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/computer_guesses')
		end
	end

	describe "post /makeguess" do 
		it "shows make guess page if new guess is a valid combination but the game is not over" do 
			post '/makeguess', :secret_code => "RRRR", :new_guess => "ROOO"

			expect(last_response.body).to include("Player 2: Please make guesses until you get 4 black pegs.")
		end

		it "shows make guess page if the guess is invalid" do 
			post '/makeguess', :secret_code => "RRRR", :new_guess => "IIII"

			expect(last_response.body).to include("Player 2: Please make guesses until you get 4 black pegs.")
		end

		it "shows the show guesses page if the game is over" do 
			post '/makeguess', :secret_code => "RRRR", :new_guess => "RRRR"

			expect(last_response.body).to include("Game over! Player 2 wins!")
		end
	end
end