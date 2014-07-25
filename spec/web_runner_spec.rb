require 'web_runner'

describe "Web Runner" do
	let(:web_runner) {WebRunner.new}

	it "gets the secret code for the computer player" do
		expect(web_runner.main).to receive(:get_secret_code)
		web_runner.get_secret_code(2)
	end

	it "gets guesses" do
		guesses = web_runner.get_guesses(2,"RRRR")
		expect(guesses.last[:guess]).to eq("RRRR")
	end

	it "checks guess" do 
		scores = web_runner.check_guess("RRYY", "RPYO")
		expect(scores).to eq([2,0])
	end

	it "adds guess to all guess" do 
		guesses = web_runner.add_guess("RRPP", [2,0])
		expect(guesses.first).to eq({:guess => "RRPP", :black => 2, :white => 0})
	end
end