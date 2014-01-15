require_relative 'mars_rover'
require_relative 'rover_command_parser'
require_relative 'grid'

class ApplicationController

  @parsed_command = nil
  @setup_data = nil
  @current_grid = nil
  @rovers_movement_data = nil
  @rovers = nil

  def self.parse_and_execute(user_input)
    parse_command(user_input)

    set_setup_data
    set_rovers_movement_data
    rovers_starting_configurations = get_starting_configurations

    create_rovers(rovers_starting_configurations)

    grid_dimensions = get_grid_dimension
    create_grid(grid_dimensions)

    puts "INITIAL POSITION OF ROVERS:"
    placeRoversOnGrid


    deliver_rover_commands
    reset_grid


    puts "FINAL POSITION OF ROVERS:"
    placeRoversOnGrid
    rovers_status = get_rovers_status


    puts "- - - - - - - - - - - - - - - - -"
    puts "FINAL OUTPUT:"
    puts rovers_status
    rovers_status
  end

  def self.parse_command(user_input)
    @parsed_command = RoverCommandParser.assess(user_input)
  end

  def self.set_setup_data
    @setup_data = @parsed_command[:setup_data]
  end

  def self.get_grid_dimension
    RoverCommandParser.get_grid_dimension(@setup_data)
  end

  def self.get_number_of_rovers
    @setup_data[:number_of_rovers]
  end

  def self.set_rovers_movement_data
    @rovers_movement_data = @parsed_command[:rovers_movement_data]
  end

  def self.create_grid(grid_dimensions)
    @current_grid = Grid.new(grid_dimensions)
  end

  def self.get_starting_configurations
    @rovers_movement_data.map {|rover| rover[:rover_movement_data][:starting_position]}
  end

  def self.create_rovers(rovers_starting_configurations)
    rovers = []
    rovers_starting_configurations.each {|starting_configuration| rovers << MarsRover.new(starting_configuration)}
    @rovers = rovers
  end

  def self.placeRoversOnGrid

    @rovers.each_with_index do |rover, index|
      avatar = (index + 1).to_s
      target_location = rover.location
      @current_grid.place_onto_grid(avatar, target_location, rover.orientation)
    end

    @current_grid.print
  end

  def self.reset_grid
    @current_grid.reset
  end

  def self.deliver_rover_commands
    rovers_commands = get_rovers_commands

    @rovers.each_with_index do |rover, index|
      rover.perform_commands(rovers_commands[index])
    end

  end

  def self.get_rovers_commands
    @rovers_movement_data.map {|rover| rover[:rover_movement_data][:commands]}
  end

  def self.get_rovers_status
    @rovers.map { |rover| rover.status}
  end

end

user_input_given =
"5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM"

ApplicationController.parse_and_execute(user_input_given)



### Uncomment Lines 125-134 to run the application with three rovers :) ###

# user_input_3_rovers =
# "4 4
# 3 2 N
# LMML
# 3 3 W
# MMR
# 4 2 S
# MRR"

# ApplicationController.parse_and_execute(user_input_3_rovers)


### Uncomment Lines 141-160 to run the application with eight rovers ###


# user_input_8_rovers =
# "8 8
# 3 4 N
# MRM
# 2 1 E
# LMMR
# 5 5 S
# MML
# 4 4 N
# MMRM
# 5 2 E
# MMR
# 0 0 N
# MMRMLL
# 7 7 S
# MMRMM
# 6 1 W
# MMRMML"

# ApplicationController.parse_and_execute(user_input_8_rovers)
