require_relative '../../lib/game/message_center.rb'

describe 'Message Center' do
	it "displays code maker message" do 
		expect(MessageCenter.ask_for_code_maker_message).to be_a(String)
	end

	it "ask_for_guesser_message" do 
		expect(MessageCenter.ask_for_guesser_message).to be_a(String)
	end

	it "secret_code_message" do 
		expect(MessageCenter.secret_code_message).to be_a(String)
	end

	it "guess_message" do 
		expect(MessageCenter.guess_message("RRRR", 5)).to be_a(String)
	end

	it "guess_checked_message" do 
		expect(MessageCenter.guess_checked_message(2,1)).to be_a(String)
	end

	it "invalid_selection_message" do 
		expect(MessageCenter.invalid_selection_message).to be_a(String)
	end

	it "player_two_wins_message" do 
		expect(MessageCenter.player_two_wins_message).to be_a(String)
	end

	it "player_one_wins_message" do 
		expect(MessageCenter.player_one_wins_message).to be_a(String)
	end
end