require_relative '../../lib/sinatra/web_main'

describe "Web Main" do 
	let(:web_main) {WebMain.new}

	it "creates a computer player" do 
		web_main = WebMain.new
		expect(web_main.get_secret_code(2).size).to eq(4)
	end
end