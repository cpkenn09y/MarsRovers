class Grid

  attr_reader :x_max, :y_max, :layout_1d, :origin_index

  def initialize(dimensions)
    @x_max = dimensions[:x_max]
    @y_max = dimensions[:y_max]
    @columns = @x_max + 1
    @rows = @y_max + 1
    @layout_1d = get_layout_1d
    @origin_index = get_origin_index
  end

  def print
    @layout_1d.each_slice(@columns) {|row| p row.join(' ')}
    add_extra_space
  end

  def reset
    @layout_1d.map! {|grid_unit| grid_unit = "0"}
  end

  def place_onto_grid(avatar, target_location, rover_orientation)
    cleaned_target_coordinate = convert_to_coordinate(target_location)
    x_coordinate = cleaned_target_coordinate[0]
    y_coordinate = cleaned_target_coordinate[1]
    puts "Placing #{avatar} at the location (#{x_coordinate}, #{y_coordinate}) #{rover_orientation}"
    grid_index_to_replace = get_grid_index_to_replace(x_coordinate, y_coordinate)
    @layout_1d[grid_index_to_replace] = avatar
  end

  private

  def get_layout_1d
    grid_units = (@columns) * (@rows)
    Array.new(grid_units) {'0'}
  end

  def add_extra_space
    puts ""
  end

  def get_origin_index
    @layout_1d.length - (@columns)
  end

  def convert_to_coordinate(starting_location)
    starting_location.split(' ').map {|coordinate| coordinate.to_i}
  end

  def get_grid_index_to_replace(x_coordinate, y_coordinate)
     @origin_index + x_coordinate - (@rows * y_coordinate)
  end

end


