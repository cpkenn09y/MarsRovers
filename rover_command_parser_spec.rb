require 'rspec'
require_relative 'rover_command_parser'

describe "RoverCommandParser" do

  user_input_1 =
    "4 4
    3 2 E
    LMR"

  user_input_2 =
    "6 6
    3 3 E
    LMR
    2 1 N
    MLM"

  user_input_3 =
    "6 6
    3 3 E
    LMR
    2 1 N
    MLM
    3 4 S
    RMM"

  it "turns user input into a usable Array and eliminates trailing whitespace" do
    expect(RoverCommandParser.clean_user_input(user_input_1)).to eq(["4 4", "3 2 E", "LMR"])
  end

  it "extracts x_max and y_max from raw dimensions data" do
    setup_data = {grid_dimension: '5 3' }
    expect(RoverCommandParser.extract_x_max_y_max(setup_data)).to eq({x_max: 5, y_max: 3})
  end

  it "determines total number of grid units from dimensions hash" do
    dimensions = {x_max: 5, y_max: 3}
    expect(RoverCommandParser.determine_number_of_grid_units(dimensions)).to eq(15)
  end

  it "extracts setup data for a single rover" do
    cleaned_user_input = ["6 6", "3 3 E", "LMR"]
    expect(RoverCommandParser.extract_setup_data(cleaned_user_input)).to eq({
        grid_dimension: '6 6', number_of_rovers: 1
      })
  end

  it "extracts set up data for two rovers" do
    cleaned_user_input = ["6 6", "3 3 E", "LMR", "2 1 N", "MLM"]
    expect(RoverCommandParser.extract_setup_data(cleaned_user_input)).to eq({
        grid_dimension: '6 6', number_of_rovers: 2
      })
  end

  it "extracts set up data for multiple rovers" do
    cleaned_user_input = ["6 6", "3 3 E", "LMR", "2 1 N", "MLM", "3 2 E", "LMM"]
    expect(RoverCommandParser.extract_setup_data(cleaned_user_input)).to eq({
        grid_dimension: '6 6', number_of_rovers: 3
      })
  end

  it "gets the grid_dimension out of setup_data" do
    cleaned_user_input = ["6 5", "3 3 E", "LMR", "2 1 N", "MLM", "3 2 E", "LMM"]
    setup_data = RoverCommandParser.extract_setup_data(cleaned_user_input)
    expect(RoverCommandParser.get_grid_dimension(setup_data)).to eq({x_max: 6, y_max: 5})
  end

  it "gets the number_of_rovers out of setup_data" do
    cleaned_user_input = ["6 6", "3 3 E", "LMR", "2 1 N", "MLM", "3 2 E", "LMM"]
    setup_data = RoverCommandParser.extract_setup_data(cleaned_user_input)
    expect(RoverCommandParser.get_number_of_rovers(setup_data)).to eq(3)
  end

  it "creates a rover hash for a single rover" do
    one_rover_data = ["3 2 E", "LMR"]
    expect(RoverCommandParser.create_rover_hashes(one_rover_data, 1)).to eq(
      [
        {
        :rover_movement_data => {starting_position: "3 2 E", directions: "LMR"}
        }
      ])
  end

  it "creates a rovers hash for multiple rovers" do
    two_rovers_data = ["3 3 E", "LMR", "2 1 N", "MLM"]
    expect(RoverCommandParser.create_rover_hashes(two_rovers_data, 2)).to eq(
      [
        {
          :rover_movement_data =>
          {
            :starting_position => "3 3 E",
            :directions => "LMR"
          }
        },
        {
          :rover_movement_data =>
          {
            starting_position: "2 1 N",
            directions: "MLM"
          }
        }
      ])
  end

  it "gets the starting_position out of rover_movement_data for one rover" do
    one_rover_data = ["3 2 E", "LMR"]
    one_rover_hash = RoverCommandParser.create_rover_hashes(one_rover_data, 1)
    expect(RoverCommandParser.get_starting_position(one_rover_hash)).to eq("3 2 E")
  end

  it "parses user_input into setup_data and a rovers_movement_data for a single rover" do
    expect(RoverCommandParser.assess(user_input_1)).to eq(
      {
        :setup_data => {grid_dimension: "4 4", number_of_rovers: 1},
        :rovers_movement_data =>
          [
            {
              :rover_movement_data => {starting_position: "3 2 E", directions: "LMR"}
            }
          ]
      })
  end

  it "parses user_input into setup_data and a rovers_movement_data for two rovers" do
    expect(RoverCommandParser.assess(user_input_2)).to eq(
      {
        :setup_data => {grid_dimension: "6 6", number_of_rovers: 2},
        :rovers_movement_data =>
          [
            {:rover_movement_data => {starting_position: "3 3 E", directions: "LMR"}},
            {:rover_movement_data=> {starting_position: "2 1 N", directions: "MLM"}}
          ]
      })
  end

  it "parses user_input into setup_data and a rovers_movement_data for multiple rover" do
    expect(RoverCommandParser.assess(user_input_3)).to eq(
      {
        :setup_data => {grid_dimension: "6 6", number_of_rovers: 3},
        :rovers_movement_data =>
          [
            {:rover_movement_data => {starting_position: "3 3 E", directions: "LMR"}},
            {:rover_movement_data => {starting_position: "2 1 N", directions: "MLM"}},
            {:rover_movement_data => {starting_position: "3 4 S", directions: "RMM"}}
          ]
      })
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