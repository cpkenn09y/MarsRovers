class Grid

  attr_reader :layout

  def initialize(dimensions)
    @layout = get_layout(dimensions)
  end

  private

  def get_layout(dimensions)
    width = dimensions[:width]
    height = dimensions[:height]
    grid_units = width * height
    Array.new(grid_units) {'0'}
  end

end