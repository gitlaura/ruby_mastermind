require_relative '../../lib/game/code_list.rb'

describe "Code List" do
	before (:each) do 
		@code_list = CodeList.new(["R", "Y", "G", "B", "P", "O"])
	end
	
	it "creates list of possible combinations" do
		expect(@code_list.possibilities[0]).to eq("RRRR")
		expect(@code_list.possibilities[1295]).to eq("OOOO")
		expect(@code_list.possibilities.size).to eq(1296)
	end

	it "updates the possibilities list" do 
		@code_list.possibilities = ["RRRR", "PROY", "GGRR", "PGRO"]
		@code_list.update_list(2, 1, "PRPO")
		expect(@code_list.possibilities).to eq(["PROY", "PGRO"])
	end

	it "adds code to the new possibilities list" do 
		@code_list.possibilities = ["RRRR", "RYPO", "GGRR"]
		@code_list.new_possibilities = []
		@code_list.update_new_possibilities(2, 2, 1, 1, 1)
		expect(@code_list.new_possibilities).to eq(["RYPO"])

		@code_list.possibilities = ["RRRR", "RYPO", "GGRR"]
		@code_list.new_possibilities = []
		@code_list.update_new_possibilities(2, 0, 3, 3, 1)
		expect(@code_list.new_possibilities).to eq([])
	end
end