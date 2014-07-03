require 'code_list.rb'

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

	it "counts the black pegs when comparing the temp_code versus the temp_guess" do 
		@code_list.temp_guess, @code_list.temp_code = "RRPP", "PORY"
		expect(@code_list.count_black_pegs).to eq(0)
		@code_list.temp_guess, @code_list.temp_code = "RRPP", "OROP"
		expect(@code_list.count_black_pegs).to eq(2)
	end	

	it "counts the white pegs when comparing the temp_code versus the temp_guess" do 
		@code_list.temp_guess, @code_list.temp_code = "RRPP", "PORY"
		expect(@code_list.count_white_pegs).to eq(2)
		@code_list.temp_guess, @code_list.temp_code = "RRPP", "OOOO"
		expect(@code_list.count_white_pegs).to eq(0)
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

	it "deletes invalid possibilities" do 
		@code_list.possibilities = ["RYPP", "INVALID", "RPPP", "INVALID"]
		@code_list.delete_invalid_possibilities
		expect(@code_list.possibilities).to eq(["RYPP", "RPPP"])
	end
end