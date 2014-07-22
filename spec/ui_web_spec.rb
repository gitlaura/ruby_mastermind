require 'ui_web.rb'

describe UIWeb do 
	it "checks the human player's guess" do
		message = UIWeb.get_result("RRPY", "RRYR")
		expect(UIWeb.black).to eq(2)
		expect(UIWeb.white).to eq(1)
	end

	it "checks the correct guess" do
		message = UIWeb.get_result("RRPY", "RRPY")
		expect(UIWeb.black).to eq(4)
		expect(UIWeb.white).to eq(0)
	end
end