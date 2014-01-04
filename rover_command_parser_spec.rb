require 'rspec'
require_relative 'rover_command_parser'

describe "RoverCommandParser" do

  it "determines number of units for grid" do
    expect(RoverCommandParser.determine_number_of_grid_units('3 3')).to eq(9)
  end

end

=begin

Rover will receive commands, and then output its current location and its orientation.

Able to move multiple rovers.

INPUT:
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM

OUTPUT:
1 3 N
5 1 E

=end