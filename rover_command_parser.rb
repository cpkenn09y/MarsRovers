module RoverCommandParser

  def self.clean_user_input(user_input)
    user_input.split("\n").map {|input| input.strip}
  end

  def self.extract_setup_data(cleaned_input)
    {:grid_dimension => cleaned_input[0], :number_of_rovers => cleaned_input.length / 2}
  end

  def self.get_grid_dimension(setup_data)
    extract_x_max_y_max(setup_data)
  end

  def self.extract_x_max_y_max(setup_data)
    raw_dimensions = setup_data[:grid_dimension]
    dimensions_separated = raw_dimensions.split(' ')
    {x_max: dimensions_separated[0].to_i, y_max: dimensions_separated[1].to_i}
  end

  def self.get_number_of_rovers(setup_data)
    setup_data[:number_of_rovers]
  end

  def self.determine_number_of_grid_units(dimensions)
    dimensions[:x_max] * dimensions[:y_max]
  end

  def self.extract_rovers_raw_data(cleaned_input)
    cleaned_input[1..-1]
  end

  def self.create_rover_hashes(rovers_data, number_of_rovers)

    rovers = []

    0.upto(number_of_rovers-1) do |i|
      rovers.push(:rover_movement_data => {
        :starting_position => rovers_data[i*2],
        :directions => rovers_data[i*2+1]
      })
    end

    rovers
  end

  def self.get_starting_position(rover_hash)
    rover_hash[0][:rover_movement_data][:starting_position]
  end

  def self.assess(user_input)
    cleaned_input = clean_user_input(user_input)

    setup_data = extract_setup_data(cleaned_input)
    number_of_rovers = setup_data[:number_of_rovers]

    rovers_raw_data = extract_rovers_raw_data(cleaned_input)
    rovers_hash = create_rover_hashes(rovers_raw_data, number_of_rovers)

    {setup_data: setup_data, rovers_movement_data: rovers_hash}
  end

end