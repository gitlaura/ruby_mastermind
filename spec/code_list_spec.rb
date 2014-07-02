require 'code_list.rb'

describe "Code List" do
	before (:each) do 
		@code_list = CodeList.new
	end
	
	it "creates list of possible combinations" do
		expect(@code_list.possibilities[0]).to eq("RRRR")
		expect(@code_list.possibilities[1295]).to eq("OOOO")
		expect(@code_list.possibilities.size).to eq(1296)
	end

	it "updates based on the number of black and white pegs it's given" do 
		expect(@code_list).to respond_to(:update_list)
		@code_list.update_list(0, 2, "GOYR")
		expect(@code_list.possibilities).to include("PYRY")
		expect(@code_list.possibilities).not_to include("GPBP")
	end
end


["R", "Y", "G", "B", "P", "O"]