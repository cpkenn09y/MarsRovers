require_relative 'mars_rover'
require_relative 'rover_command_parser'
require_relative 'grid'

class ApplicationController

  class << self

    @parsed_command = nil
    @setup_data = nil
    @current_grid = nil
    @rovers_movement_data = nil
    @rovers = nil

    def parse_and_execute(user_input)
      parse_command(user_input)

      set_setup_data
      set_rovers_movement_data
      rovers_starting_configurations = get_starting_configurations

      create_rovers(rovers_starting_configurations)

      grid_dimensions = get_grid_dimension
      create_grid(grid_dimensions)

      puts "INITIAL POSITION OF ROVERS:"
      place_rovers_on_grid
      print_grid

      deliver_rover_commands
      reset_grid


      puts "FINAL POSITION OF ROVERS:"
      place_rovers_on_grid
      print_grid
      rovers_status = get_rovers_status


      puts "- - - - - - - - - - - - - - - - -"
      puts "FINAL OUTPUT:"
      puts rovers_status
      rovers_status
    end

    def parse_command(user_input)
      @parsed_command = RoverCommandParser.assess(user_input)
    end

    def set_setup_data
      @setup_data = @parsed_command[:setup_data]
    end

    def get_grid_dimension
      RoverCommandParser.get_grid_dimension(@setup_data)
    end

    def get_number_of_rovers
      @setup_data[:number_of_rovers]
    end

    def set_rovers_movement_data
      @rovers_movement_data = @parsed_command[:rovers_movement_data]
    end

    def create_grid(grid_dimensions)
      @current_grid = Grid.new(grid_dimensions)
    end

    def get_starting_configurations
      @rovers_movement_data.map {|rover| rover[:rover_movement_data][:starting_position]}
    end

    def create_rovers(rovers_starting_configurations)
      rovers = []
      rovers_starting_configurations.each {|starting_configuration| rovers << MarsRover.new(starting_configuration)}
      @rovers = rovers
    end

    def place_rovers_on_grid

      @rovers.each_with_index do |rover, index|
        avatar = (index + 1).to_s
        target_location = rover.location
        @current_grid.place_onto_grid(avatar, target_location, rover.orientation)
      end

    end

    def print_grid
      @current_grid.print
    end

    def reset_grid
      @current_grid.reset
    end

    def deliver_rover_commands
      rovers_commands = get_rovers_commands

      @rovers.each_with_index do |rover, index|
        rover.perform_commands(rovers_commands[index])
      end

    end

    def get_rovers_commands
      @rovers_movement_data.map {|rover| rover[:rover_movement_data][:commands]}
    end

    def get_rovers_status
      @rovers.map { |rover| rover.status}
    end

  end

end