require 'rspec'
require_relative 'grid'

describe "Grid" do

  before(:each) do
    @my_grid = Grid.new({x_max: 2, y_max: 2})
  end

  context "Initialization:" do

    it "creates a 1-d Array based on initialization argument" do
      expect(@my_grid.x_max).to eq(2)
      expect(@my_grid.y_max).to eq(2)
    end

  end

  context "Get Origin:" do

    it "calculates the index of the origin based on grid dimensions" do
      expect(@my_grid.origin_index).to eq(6)
    end

  end

  context "Place Onto Grid:" do

    it "is able to place an avatar onto the origin" do
      avatar = '1'
      starting_location = '0 0'
      orientation = 'N'
      @my_grid.place_onto_grid(avatar, starting_location, orientation)
      expect(@my_grid.layout_1d).to eq(['0', '0', '0',
                                        '0', '0', '0',
                                        '1', '0', '0'])
    end

    it "is able to place an avatar onto any specified starting location" do
      avatar = '1'
      starting_location = '2 1'
      orientation = 'S'
      @my_grid.place_onto_grid(avatar, starting_location, orientation)
      expect(@my_grid.layout_1d).to eq(['0', '0', '0',
                                        '0', '0', '1',
                                        '0', '0', '0',])
    end

  end

end