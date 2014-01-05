require 'rspec'
require_relative 'mars_rover'

describe "MarsRover" do

  my_rover = MarsRover.new('1 2 N')

  it "has a starting location" do
    expect(my_rover.location).to eq('1 2')
  end

  it "has a starting directional orientation" do
    expect(my_rover.orientation).to eq('N')
  end

  it "outputs its status: location and directional orientation" do
    expect(my_rover.status).to eq('1 2 N')
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

# WILL LIKELY CREATE A INPUT PARSER MODULE
# WILL LIKELY CREATE A CLASS THAT CREATES A GRID BASED ON THE FIRST LINE OF CODE
# HAVE A MODULE CALLED mars_rover.rb <- which deals with state that a mars rover would have like knowing its position & orientation & stuff (color?)
# CREATE A CONFIG.ru <- which will require all the components, so that application.rb will only require the config.ru
# CREATE A FILE CALLED APPLICATION RB <- which plays with the mars_rover, rover_command_parser, grid_creator
