require_relative '../../lib/command_line/command_line_io.rb'

class TestClass
end

describe "Command Line IO" do
 	before(:each) do
 		@test_class = TestClass.new
 		@test_class.extend(CommandLineIO)

		@input = StringIO.new("test info\n")
		@output = StringIO.new

 		@input_received = @test_class.receive(input = @input)
 		@test_class.give("test message", output = @output)
 	end

 	it "should output a message for the user" do
 		expect(@output.string).to include("test message")
 	end

 	it "should return the user's input" do
 		expect(@input_received).to eq("test info")
 	end
end