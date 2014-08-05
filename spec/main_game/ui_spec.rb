require_relative '../../lib/main_game/ui.rb'

class TestClass
end

describe "UI" do
 	before(:each) do
 		@test_class = TestClass.new
 		@test_class.extend(UI)

		@input = StringIO.new("test info\n")
		@output = StringIO.new

 		@input_received = @test_class.receive(input: @input)
 		@test_class.give("test message", output: @output)
 	end

 	it "should output a message for the user" do
 		expect(@output.string).to eq("\ntest message\n")
 	end

 	it "should return the user's input" do
 		expect(@input_received).to eq("test info")
 	end

end