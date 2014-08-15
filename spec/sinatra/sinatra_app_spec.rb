require_relative '../../lib/sinatra/sinatra_app'
require 'rspec'
require 'rack/test'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    SinatraApp.new
  end

  context "get routes" do
	  it "/ displays code_maker page" do
			get '/'
			expect(last_response).to be_ok
			expect(last_response.body).to include("Player #1 will select the secret code. Which type of player would you like?")
		end

		it "/secret_code displays secret code " do
			get '/secret_code'
			expect(last_response).to be_ok
			expect(last_response.body).to include("secret code")
		end

		it "/guesser displays the guesser page" do
			get '/guesser'
			expect(last_response).to be_ok
			expect(last_response.body).to include("Which type of player would you like?")
		end

		it "/guess creates a secret code" do
			get '/guess'
			expect(last_response.body).to include("Player 2: Please make guesses")
		end

		it "/game_over displays guesses" do
			get '/game_over', {}, 'rack.session' => {:guesses => ["RRRR",4,0] }
			expect(last_response.body).to include("Player 2's Guesses:")
		end
	end

  context "post routes" do
  	before (:each) do 
  		get "/", 'rack.session' => {:secret_code => ["RRRR"], :message => "Hello world"}
  	end

		it "/code_maker gets a code from computer player" do
			post "/code_maker", :code_maker => "2"

			expect(last_response.redirect?).to be_true
			follow_redirect!
      expect(last_request.path).to eq('/guesser')
		end

		it "/code_maker gets a code from human" do 
			post "/code_maker", :code_maker => "1"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/secret_code')
		end

		it "/secret_code sets code if code is valid" do 
			post "/secret_code", :secret_code => "RRPP"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/guesser')
		end

		it "/secret_code asks for new code if code is invalid" do 
			post "/secret_code", :secret_code => "rr9p"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/secret_code')
		end

		it "/guesser gets guesses from computer" do
			post "/code_maker", :code_maker => "2"
			post "/guesser", :guesser => "2"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/game_over')
		end

		it "/guesser gets guesses from human" do
			post "/code_maker", :code_maker => "2"
			post "/guesser", :guesser => "1"

			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/guess')
		end

		it "/newguess gets human guesses if guess is valid" do
			post "/code_maker", :code_maker => "2"
			post "/guesser", :guesser => "1"
			post "/newguess", :new_guess => "RRPP"
			
			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/guess')
		end

		it "/newguess gets guess again if guess is invalid" do
			post "/code_maker", :code_maker => "2"
			post "/newguess", :new_guess => "mmmmmm"
			
			expect(last_response.redirect?).to be_true
      follow_redirect!
      expect(last_request.path).to eq('/guess')
		end
	end
end