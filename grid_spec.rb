require 'rspec'
require_relative 'grid'

describe "Grid" do

  it "creates a 1-d Array based on initialization argument" do
    expect(Grid.new({height: 3, width: 2}).layout).to eq(['0', '0', '0', '0', '0', '0'])
  end

end