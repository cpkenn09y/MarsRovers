require_relative 'spec_helper'

describe "ApplicationController" do

user_input =
"5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM"

  before(:each) do
    @parsed_command = ApplicationController.parse_command(user_input)
    @setup_data = ApplicationController.set_setup_data
    @rovers_movement_data = ApplicationController.set_rovers_movement_data
    @rovers_starting_configurations = ApplicationController.get_starting_configurations
    @rovers = ApplicationController.create_rovers(@rovers_starting_configurations)
  end

  context "Parse Command:" do
    it "returns set up data and rovers movement data" do
      expect(@parsed_command).to eq(
        {
          :setup_data =>
            {
              grid_dimension: "5 5",
              number_of_rovers: 2
            },
          :rovers_movement_data =>
            [
              {:rover_movement_data => {starting_position: "1 2 N", commands: "LMLMLMLMM" }},
              {:rover_movement_data => {starting_position: "3 3 E", commands: "MMRMMRMRRM"}}
            ]
        }
      )
    end
  end

  context "Set Up Data:" do
    it "extracts set up data out of the parsed command" do
      expect(@setup_data).to eq(
        {:grid_dimension => "5 5", :number_of_rovers => 2}
      )
    end
  end

  context "Get Grid Dimension:" do
    it "return a hash of x_max and y_max" do
      expect(ApplicationController.get_grid_dimension).to eq(
        {:x_max => 5, :y_max => 5}
      )
    end
  end

  context "Get Number of Rovers:" do

    it "calculates number of rovers based on set up data" do
      expect(ApplicationController.get_number_of_rovers).to eq(2)
    end

  end

  context "Rovers Movement Data:" do

    it "returns an array of rover movement data hashes" do
      expect(@rovers_movement_data).to eq(
        [
          {
            :rover_movement_data => { starting_position: "1 2 N", commands: "LMLMLMLMM"}
          },
          {
            :rover_movement_data => {starting_position: "3 3 E", :commands=>"MMRMMRMRRM"}
          }
        ]
      )
    end

  end

  context "Get Starting Configurations:" do

    it "returns an array with starting position of rovers" do
      expect(@rovers_starting_configurations).to eq(["1 2 N", "3 3 E"])
    end

  end

  context "Deliver Rover Commands:" do

    it "provides each rover with its commands, leading to the execution of said commands" do
      ApplicationController.deliver_rover_commands
      rover_1_status = @rovers[0].status
      expect(rover_1_status).to eq("1 3 N")
    end

  end

end