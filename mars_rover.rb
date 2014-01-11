class MarsRover

  POSSIBLE_COMMANDS = [{"M" => "Move Forward"}, {"R" => "Turn Right"}, {"L" => "Turn Left"}]

  attr_reader :location, :orientation

  def initialize(configuration)
    @location = get_location(configuration)
    @orientation = get_orientation(configuration)
    @status = status
  end

  def status
    @location + ' ' + @orientation
  end

  def get_location(configuration)
    configuration.slice(0..2)
  end

  def get_orientation(configuration)
    configuration.slice(-1)
  end

  def perform_commands(commands)
    split_commands = commands.split('')
    split_commands.each do |command|
      determine_correct_action(command)
    end
  end

  def determine_correct_action(command)
    case command
    when "M"
      move_forward
    when "R"
      turn_right
    when "L"
      turn_left
    else
      invalid_command = command
      print_command_error(invalid_command)
    end
  end

  def print_command_error(invalid_command)
    puts "You have provided an invalid command"
    puts "The command you provided, #{invalid_command}, has to match one of the commands below"
    puts "HERE IS THE LIST OF POSSIBLE COMMANDS:"
    POSSIBLE_COMMANDS.each do |possible_command|
      possible_command.each {|command, description| puts "#{command} <-- #{description}"}
    end
  end

  def move_forward
    case @orientation
    when "N"
      @location[-1] = "#{@location[-1].to_i + 1}"
    when "S"
      @location[-1] = "#{@location[-1].to_i - 1}"
    when "E"
      @location[0] = "#{@location[0].to_i + 1}"
    when "W"
      @location[0] = "#{@location[0].to_i - 1}"
    else
      puts "Rover's current orientation is invalid"
    end
    update_status
  end

  def turn_right
    case @orientation
    when "N"
      @orientation = "E"
    when "S"
      @orientation = "W"
    when "E"
      @orientation = "S"
    when "W"
      @orientation = "N"
    end
    update_status
  end

  def turn_left
    case @orientation
    when "N"
      @orientation = "W"
    when "S"
      @orientation = "E"
    when "E"
      @orientation = "N"
    when "W"
      @orientation = "S"
    end
    update_status
  end

  def update_status
    @status = status
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