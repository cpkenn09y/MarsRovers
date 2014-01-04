class Grid

  attr_reader :layout

  def initialize(units)
    @layout = Array.new(units) {'0'}
  end

end