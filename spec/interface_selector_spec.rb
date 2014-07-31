require 'interface_selector'

describe 'Interface Selector' do
	it "returns a valid selection" do
		expect(InterfaceSelector).to receive(:give)
		expect(InterfaceSelector).to receive(:receive) {1}

		expect(InterfaceSelector.get_interface).to eq(1)
	end
end