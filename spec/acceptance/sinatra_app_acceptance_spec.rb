require_relative '../../lib/sinatra/sinatra_app'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome do |app|
  	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end	

Capybara.current_driver = :selenium_chrome
Capybara.run_server = false
Capybara.app_host = 'http://laura-mastermind.herokuapp.com'
Capybara.app = SinatraApp.new

describe "The Sinatra App", :type => :feature do
  context "homepage" do
	  it "welcomes you to the game" do 
	  	visit '/'

	  	expect(page).to have_content "Let's Play Mastermind!"
	  end

	  it "selects a human code maker" do 
	  	visit '/'
	  	choose('human') 
	  	click_button "submit"

	  	expect(current_path).to eq('/secret_code')
	  	expect(page).to have_content "Please select a secret code"
	  end

	  it "selects a computer code maker" do 
	  	visit '/'
	  	choose('computer') 
	  	click_button "submit"

	  	expect(current_path).to eq('/guesser')
	  	expect(page).to have_content "Player #2 will try to guess the secret code in less than 10 tries"
	  end
	end

	context "secret code page" do
		before(:each) do 
			visit '/'
	  	choose('human') 
	  	click_button "submit"
		end

		it "shows the correct instructions" do
			visit '/secret_code'

			expect(page).to have_content "Please select a secret code"
		end

		it "provides error message for invalid response" do 
			visit '/secret_code'
			fill_in('secret_code', :with => '7788')
			click_button "submit"

			expect(current_path).to eq('/secret_code')
			expect(page).to have_content "Try again"
		end

		it "accepts a valid secret code" do 
			visit '/secret_code'
			fill_in('secret_code', :with => 'rrpp')
			click_button "submit"

			expect(page).to have_content "Player #2 will try to guess the secret code in less than 10 tries"
			expect(current_path).to eq('/guesser')
		end
	end

	context "guesser page" do
		before(:each) do 
			visit '/'
	  	choose('computer') 
	  	click_button "submit"
		end

		it "shows the correct instructions" do
			visit '/guesser'

			expect(page).to have_content "Which type of player would you like?"
		end

		it "selects a human guesser" do 
	  	visit '/guesser'
	  	choose('human') 
	  	click_button "submit"

	  	expect(current_path).to eq('/guess')
	  	expect(page).to have_content "Please make guesses until you get 4 black pegs"
	  end

	  it "selects a computer code maker" do 
	  	visit '/guesser'
	  	choose('computer') 
	  	click_button "submit"

	  	expect(current_path).to eq('/game_over')
	  	expect(page).to have_content "Player 2's Guesses"
	  end
	end

	context "guess page" do
		before(:each) do 
			visit  '/'
	  	choose('computer') 
	  	click_button "submit"
	  	choose('human')
	  	click_button "submit"
		end

		it "shows the correct instructions" do
			visit '/guess'

			expect(page).to have_content "Please make guesses until you get 4 black pegs"
		end

		it "provides error message for invalid guess" do 
			visit  '/guess'
			fill_in('new_guess', :with => '7788')
			click_button "submit"

			expect(current_path).to eq('/guess')
			expect(page).to have_content "Try again"
		end

		it "shows guess if the guess was valid" do 
			visit '/guess'
			fill_in('new_guess', :with => 'rroo')
			click_button "submit"

			expect(current_path).to eq('/guess')
			expect(page).to have_content "RROO"
		end
	end

	context "game over page" do
		it "shows the final guesses if player 2 is a computer" do
			visit  '/'
		  choose('computer') 
		  click_button "submit"
		  choose('computer')
		 	click_button "submit"

		 	expect(current_path).to eq('/game_over')
		 	expect(page).to have_content "Player 2's Guesses"
		end

		it "shows the final guesses if player 2 is a human" do
			visit  '/'
		  choose('human') 
		  click_button "submit"
		  fill_in('secret_code', :with => 'rroo')
			click_button "submit"
		  choose('human')
		  click_button "submit"
		 	fill_in('new_guess', :with => 'rrpp')
		 	click_button "submit"
		 	fill_in('new_guess', :with => 'rroo')
			click_button "submit"

			expect(current_path).to eq('/game_over')
		 	expect(page).to have_content "Player 2's Guesses"
		 	expect(page).to have_content "RRPP"
		 	expect(page).to have_content "RROO"
		end
	end
end