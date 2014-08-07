require_relative '../../lib/game/code_list.rb'

describe "Code List" do
	let(:code_list) {CodeList.new(["R", "Y", "G", "B", "P", "O"])}
	
	it "creates list of possible combinations" do
		expect(code_list.possibilities[0]).to eq("RRRR")
		expect(code_list.possibilities[1295]).to eq("OOOO")
		expect(code_list.possibilities.size).to eq(1296)
	end

	it "updates the possibilities list" do 
		code_list.possibilities = ["RRRR", "PROY", "GGRR", "PGRO"]
		code_list.update_list(2, 1, "PRPO")
		expect(code_list.possibilities).to eq(["PROY", "PGRO"])
	end

	it "checks to see if possibility has the correct number of counters" do 
		black, blackcounter = 1, 1
		white, whitecounter = 1, 1

		result = code_list.possibility_has_correct_number_of_colors?(black, blackcounter, white, whitecounter)

		expect(result).to eq(true)
	end

	it "returns false if the possible code has the wrong number of correct colors" do 
		black, blackcounter = 1, 1
		white, whitecounter = 1, 2

		result = code_list.possibility_has_correct_number_of_colors?(black, blackcounter, white, whitecounter)

		expect(result).to eq(false)
	end
end