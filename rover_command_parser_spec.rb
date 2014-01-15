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

  context "Clean User Input:" do

    it "returns an array containing each line of user input" do
      expect(RoverCommandParser.clean_user_input(user_input_1)).to eq(["4 4", "3 2 E", "LMR"])
    end

  end

  context "Extract Set-Up Data:" do

    it "returns a hash containing grid dimension and number of rovers; single rover" do
      cleaned_user_input = ["6 6", "3 3 E", "LMR"]
      expect(RoverCommandParser.extract_setup_data(cleaned_user_input)).to eq({
          grid_dimension: '6 6', number_of_rovers: 1
        })
    end

    it "returns a hash containing grid dimension and number of rovers; multiple rovers" do
      cleaned_user_input = ["6 6", "3 3 E", "LMR", "2 1 N", "MLM", "3 2 E", "LMM"]
      expect(RoverCommandParser.extract_setup_data(cleaned_user_input)).to eq({
          grid_dimension: '6 6', number_of_rovers: 3
        })
    end

  end

  context "Get Grid Dimension:" do

    it "returns the grid dimension data contained within the set-up data" do
      cleaned_user_input = ["6 5", "3 3 E", "LMR", "2 1 N", "MLM", "3 2 E", "LMM"]
      setup_data = RoverCommandParser.extract_setup_data(cleaned_user_input)
      expect(RoverCommandParser.get_grid_dimension(setup_data)).to eq({x_max: 6, y_max: 5})
    end

  end

  context "Get Number of Rovers:" do

    it "returns the number of rovers data contained within set-up data" do
      cleaned_user_input = ["6 6", "3 3 E", "LMR", "2 1 N", "MLM", "3 2 E", "LMM"]
      setup_data = RoverCommandParser.extract_setup_data(cleaned_user_input)
      expect(RoverCommandParser.get_number_of_rovers(setup_data)).to eq(3)
    end

  end

  context "Rover Hash:" do

    it "contains rover movement data which then contains starting position and commands" do
      one_rover_data = ["3 2 E", "LMR"]
      expect(RoverCommandParser.create_rover_hashes(one_rover_data, 1)).to eq(
        [
          {
          :rover_movement_data => {starting_position: "3 2 E", commands: "LMR"}
          }
        ])
    end

    it "for multiple rovers, contains movement data which each contains starting position and commands" do
      two_rovers_data = ["3 3 E", "LMR", "2 1 N", "MLM"]
      expect(RoverCommandParser.create_rover_hashes(two_rovers_data, 2)).to eq(
        [
          {
            :rover_movement_data =>
            {
              :starting_position => "3 3 E",
              :commands => "LMR"
            }
          },
          {
            :rover_movement_data =>
            {
              starting_position: "2 1 N",
              commands: "MLM"
            }
          }
        ])
    end

  end

  context "Get Starting Position:" do

    it "for one rover, gets the starting_position out of rover_movement_data" do
      one_rover_data = ["3 2 E", "LMR"]
      one_rover_hash = RoverCommandParser.create_rover_hashes(one_rover_data, 1)
      expect(RoverCommandParser.get_starting_position(one_rover_hash)).to eq("3 2 E")
    end

  end

  context "Assess:" do

    it "for one rover, returns rover set-up data and and rovers movement data" do
      expect(RoverCommandParser.assess(user_input_1)).to eq(
        {
          :setup_data => {grid_dimension: "4 4", number_of_rovers: 1},
          :rovers_movement_data =>
            [
              {
                :rover_movement_data => {starting_position: "3 2 E", commands: "LMR"}
              }
            ]
        })
    end

    it "for two rovers, returns each set-up data and and each rover's movement data" do
      expect(RoverCommandParser.assess(user_input_2)).to eq(
        {
          :setup_data => {grid_dimension: "6 6", number_of_rovers: 2},
          :rovers_movement_data =>
            [
              {:rover_movement_data => {starting_position: "3 3 E", commands: "LMR"}},
              {:rover_movement_data=> {starting_position: "2 1 N", commands: "MLM"}}
            ]
        })
    end

    it "for multiple rovers, returns rover set-up data and each rover's movement data" do
      expect(RoverCommandParser.assess(user_input_3)).to eq(
        {
          :setup_data => {grid_dimension: "6 6", number_of_rovers: 3},
          :rovers_movement_data =>
            [
              {:rover_movement_data => {starting_position: "3 3 E", commands: "LMR"}},
              {:rover_movement_data => {starting_position: "2 1 N", commands: "MLM"}},
              {:rover_movement_data => {starting_position: "3 4 S", commands: "RMM"}}
            ]
        })
    end

  end

end