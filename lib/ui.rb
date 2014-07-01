module UI
	def give(output_message, output: $stdout)
		output.puts output_message
	end

	def receive(input: $stdin)
		input.gets.chomp
	end
end