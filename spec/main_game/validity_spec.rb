require_relative '../../lib/main_game/validity.rb'

class TestClass
end

describe "Validity" do 
	before(:each) do 
		test_class = TestClass.new
 		@test_class.extend(Validity)
	end

	it "checks for a valid selection" do 
		expect(@test_class.valid_interface?(2)).to eq(true)
		expect(@test_class.valid_interface?(4)).to eq(false)
		expect(@test_class.valid_interface?(0)).to eq(false)
	end

	it "checks for a valid player" do 
		expect(@test_class.valid_player?(2)).to eq(true)
		expect(@test_class.valid_player?(4)).to eq(false)
		expect(@test_class.valid_player?(0)).to eq(false)
	end

	it "checks for a valid combination" do 
		expect(@test_class.valid_combination?("YPRO")).to eq(true)
		expect(@test_class.valid_combination?("YWR")).to eq(false)
		expect(@test_class.valid_combination?("YP5O*")).to eq(false)
	end
end