require 'rspec'
require_relative 'mars_rover'

describe "MarsRover" do

  before(:each) {
    @my_rover_north = MarsRover.new('1 2 N')
    @my_rover_south = MarsRover.new('1 2 S')
    @my_rover_east = MarsRover.new('1 2 E')
    @my_rover_west = MarsRover.new('1 2 W')
  }

  context "Initialization:" do

    it "has a starting location" do
      expect(@my_rover_north.location).to eq('1 2')
    end

    it "has a directional orientation" do
      expect(@my_rover_north.orientation).to eq('N')
    end

    it "has a status which contains location and directional orientation" do
      expect(@my_rover_north.status).to eq('1 2 N')
    end

  end

  context 'Moves Forward:' do

    it "when facing North" do
      @my_rover_north.move_forward
      expect(@my_rover_north.status).to eq('1 3 N')
    end

    it "when facing South" do
      @my_rover_south.move_forward
      expect(@my_rover_south.status).to eq('1 1 S')
    end

    it "when facing East" do
      @my_rover_east.move_forward
      expect(@my_rover_east.status).to eq('2 2 E')
    end

    it "when facing West" do
      @my_rover_west.move_forward
      expect(@my_rover_west.status).to eq('0 2 W')
    end

  end

  context "Right Turn:" do

    it "changes orientation from North to East" do
      @my_rover_north.turn_right
      expect(@my_rover_north.orientation).to eq('E')
    end

    it "changes orientation from South to West" do
      @my_rover_south.turn_right
      expect(@my_rover_south.orientation).to eq('W')
    end

    it "changes orientation from East to South" do
      @my_rover_east.turn_right
      expect(@my_rover_east.orientation).to eq('S')
    end

    it "changes orientation from West to North" do
      @my_rover_west.turn_right
      expect(@my_rover_west.orientation).to eq('N')
    end

  end

  context "Left Turn:" do

    it "changes orientation from North to West" do
      @my_rover_north.turn_left
      expect(@my_rover_north.orientation).to eq('W')
    end

    it "changes orientation from South to East" do
      @my_rover_south.turn_left
      expect(@my_rover_south.orientation).to eq('E')
    end

    it "changes orientation from East to North" do
      @my_rover_east.turn_left
      expect(@my_rover_east.orientation).to eq('N')
    end

    it "changes orientation from West to South" do
      @my_rover_west.turn_left
      expect(@my_rover_west.orientation).to eq('S')
    end

  end

  context "Perform Commands:" do

    it "properly moves in response to valid commands" do
      @my_rover_north.perform_commands("MLM")
      expect(@my_rover_north.status).to eq('0 3 W')

      @my_rover_west.perform_commands("LMLM")
      expect(@my_rover_west.status).to eq('2 1 E')
    end

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
