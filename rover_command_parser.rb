require 'debugger'

module RoverCommandParser

  def self.clean_user_input(user_input)
    user_input.split("\n").map {|input| input.strip}
  end

  def self.extract_setup_data(cleaned_input)
    {:grid_dimension => cleaned_input[0], :number_of_rovers => cleaned_input.length / 2}
  end

  def self.extract_height_width(raw_dimensions)
    dimensions_separated = raw_dimensions.split(' ')
    {height: dimensions_separated[0].to_i, width: dimensions_separated[1].to_i}
  end

  def self.determine_number_of_grid_units(dimensions)
    dimensions[:height] * dimensions[:width]
  end

  def self.extract_rovers_raw_data(cleaned_input)
    cleaned_input[1..-1]
  end

  def self.create_rovers_hash(rovers_data, number_of_rovers)

    rovers = []

    0.upto(number_of_rovers-1) do |i|
      rovers.push(:rover_movement_data => {
        :starting_position => rovers_data[i*2],
        :directions => rovers_data[i*2+1]
      })
    end

    rovers
  end

  def self.assess(user_input)
    cleaned_input = clean_user_input(user_input)

    setup_data = extract_setup_data(cleaned_input)
    number_of_rovers = setup_data[:number_of_rovers]

    rovers_raw_data = extract_rovers_raw_data(cleaned_input)
    rovers_hash = create_rovers_hash(rovers_raw_data, number_of_rovers)

    {setup_data: setup_data, rovers_hash: rovers_hash}
  end

end