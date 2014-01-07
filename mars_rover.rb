class MarsRover

  attr_reader :location, :orientation, :status

  def initialize(configuration)
    @location = get_location(configuration)
    @orientation = get_orientation(configuration)
    @status = get_status
  end

  def get_location(configuration)
    configuration.slice(0..2)
  end

  def get_orientation(configuration)
    configuration.slice(-1)
  end

  def get_status
    @location + ' ' + @orientation
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
  end

  def turn_left
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