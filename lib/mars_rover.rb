class MarsRover

  POSSIBLE_COMMANDS = [{"M" => "Move Forward"}, {"R" => "Turn Right"}, {"L" => "Turn Left"}]
  COMPASS = {north: "N", south: "S", east: "E", west: "W"}

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
    when COMPASS[:north]
      @location[-1] = "#{@location[-1].to_i + 1}"
    when COMPASS[:south]
      @location[-1] = "#{@location[-1].to_i - 1}"
    when COMPASS[:east]
      @location[0] = "#{@location[0].to_i + 1}"
    when COMPASS[:west]
      @location[0] = "#{@location[0].to_i - 1}"
    else
      puts "Rover's current orientation is invalid"
    end
    update_status
  end

  def turn_right
    case @orientation
    when COMPASS[:north]
      @orientation = COMPASS[:east]
    when COMPASS[:south]
      @orientation = COMPASS[:west]
    when COMPASS[:east]
      @orientation = COMPASS[:south]
    when COMPASS[:west]
      @orientation = COMPASS[:north]
    end
    update_status
  end

  def turn_left
    case @orientation
    when COMPASS[:north]
      @orientation = COMPASS[:west]
    when COMPASS[:south]
      @orientation = COMPASS[:east]
    when COMPASS[:east]
      @orientation = COMPASS[:north]
    when COMPASS[:west]
      @orientation = COMPASS[:south]
    end
    update_status
  end

  def update_status
    @status = status
  end

end