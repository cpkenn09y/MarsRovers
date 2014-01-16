require_relative 'application_controller'

class MarsRoverApplication

  def initialize(argv)
    @file = assess_argv_for_file(argv)
    @content = read_content
    close_file
  end

  def run!
    setup_application
    place_rovers_at_initial_position
    execute_commands
    display_results
  end

  private

  def setup_application
    ApplicationController.parse_command(@content)
    ApplicationController.set_setup_data
    ApplicationController.set_rovers_movement_data
    rovers_starting_configurations = ApplicationController.get_starting_configurations
    ApplicationController.create_rovers(rovers_starting_configurations)
    grid_dimensions = ApplicationController.get_grid_dimension
    ApplicationController.create_grid(grid_dimensions)
  end

  def place_rovers_at_initial_position
    puts "INITIAL POSITION OF ROVERS:"
    ApplicationController.place_rovers_on_grid
    ApplicationController.print_grid
  end

  def execute_commands
    ApplicationController.deliver_rover_commands
    ApplicationController.reset_grid
  end

  def display_results
    puts "FINAL POSITION OF ROVERS:"
    ApplicationController.place_rovers_on_grid
    ApplicationController.print_grid

    puts "- - - - - - - - - - - - - - - - -"
    puts "FINAL OUTPUT:"
    rovers_status = ApplicationController.get_rovers_status
    puts rovers_status
    rovers_status
  end

  def assess_argv_for_file(argv)
    if argv.empty?
      return File.open("TW_input.txt")
    else
      return File.open(argv[0])
    end
  end

  def read_content
    @file.read
  end

  def close_file
    @file.close
  end

end

if ARGV[0] != "mars_rover_application_spec.rb"
  my_application = MarsRoverApplication.new(ARGV)
  my_application.run!
end