class RoverApplication

  attr_reader :file

  def initialize(argv=["TW_input.txt"])
    @file = argv[0]
    @content = build_content
    @grid = build_grid
    @rovers = build_rovers
    close_file
  end

  def run!

  end

  private

  def build_content
    @file.readlines
  end

  def close_file
    @file.close
  end

  def build_grid
    Grid.new(@content[0])
  end

  def build_rovers
    rovers_data.map {|rover_data| Rover.new(rover_data)}
  end

  def rovers_data
    extract_rovers_and_commands.each_slice(2).map do |pair|
      pair.first
    end
  end

  def extract_rovers_and_commands
    @content[1..-1]
  end

  def place_rovers_on_grid
    @rovers.each do |rover|
      @grid.place_on_grid(rover)
    end
  end

end


#   ApplicationController.parse_and_execute(user_input)
# when "application_controller_spec.rb"
# else
#   f = File.open(ARGV[0])
#   user_input = f.read
#   f.close

#   ApplicationController.parse_and_execute(user_input)
# end