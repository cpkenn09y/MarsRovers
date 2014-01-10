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
    @layout_1d.each_slice(@columns) {|row| p row}
  end

  def get_origin_index
    @layout_1d.length - (@columns)
  end

  def place_onto_grid(avatar, starting_location)
    starting_coordinate = convert_to_coordinate(starting_location)
    x_coordinate = starting_coordinate[0]
    y_coordinate = starting_coordinate[1]
    grid_index_to_replace = get_grid_index_to_replace(x_coordinate, y_coordinate)
    @layout_1d[grid_index_to_replace] = avatar
  end

  private

  def get_layout_1d
    grid_units = (@columns) * (@rows)
    Array.new(grid_units) {'0'}
  end

  def convert_to_coordinate(starting_location)
    starting_location.split(' ').map {|coordinate| coordinate.to_i}
  end

  def get_grid_index_to_replace(x_coordinate, y_coordinate)
     @origin_index + x_coordinate - (@rows * y_coordinate)
  end

end


