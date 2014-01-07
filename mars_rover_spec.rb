require 'rspec'
require_relative 'mars_rover'

describe "MarsRover" do

  my_rover_north = MarsRover.new('1 2 N')
  my_rover_south = MarsRover.new('1 2 S')
  my_rover_east = MarsRover.new('1 2 E')
  my_rover_west = MarsRover.new('1 2 W')

  it "has a starting location" do
    expect(my_rover_north.location).to eq('1 2')
  end

  it "has a starting directional orientation" do
    expect(my_rover_north.orientation).to eq('N')
  end

  it "outputs its status: location and directional orientation" do
    expect(my_rover_north.status).to eq('1 2 N')
  end

  it "is able to move forward when facing North" do
    my_rover_north.move_forward
    expect(my_rover_north.get_status).to eq('1 3 N')
  end

  it "is able to move forward when facing South" do
    my_rover_south.move_forward
    expect(my_rover_south.get_status).to eq('1 1 S')
  end

  it "is able to move forward when facing East" do
    my_rover_east.move_forward
    expect(my_rover_east.get_status).to eq('2 2 E')
  end

  it "is able to move forward when facing West" do
    my_rover_west.move_forward
    expect(my_rover_west.get_status).to eq('0 2 W')
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
