module RoverCommandParser

  def self.determine_number_of_grid_units(dimensions)
    number_of_grid_units = 1
    dimensions.split(' ').each {|dimension| number_of_grid_units *= dimension.to_i}
    number_of_grid_units
  end

end