require_relative 'mars_rover_application'

class MockRoverApp < MarsRoverApplication

  attr_reader :content

  def initialize(file_name)
    @file = File.open(file_name)
    @content = read_content
    close_file
  end
end