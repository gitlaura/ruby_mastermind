require 'message_center.rb'

describe 'Message Center' do
	before(:each) do 
		@message_center = MessageCenter.new
	end

	it "gets the code maker" do 
		@message_center.should_receive(:give)
		@message_center.should_receive(:receive) {2}
		@message_center.get_code_maker
	end

	it "gets the guesser" do 
		@message_center.should_receive(:give)
		@message_center.should_receive(:receive) {2}
		@message_center.get_guesser
	end

	it "display_code_message" do 
		@message_center.should_receive(:give)
		@message_center.display_code_message
	end

	it "display_guess" do 
		@message_center.should_receive(:give)
		@message_center.display_guess("YYYY")
	end

	it "display_results" do 
		@message_center.should_receive(:give)
		@message_center.display_results(1, 3)
	end

	it "end game" do 
		@message_center.should_receive(:give).twice
		@message_center.goodbye(5)
		@message_center.game_over
	end
end