require 'rspec'
require_relative '../mars_rover_application'
require_relative '../lib/application_controller'
require_relative '../lib/grid'
require_relative '../lib/mars_rover'
require_relative '../lib/rover_command_parser'

class MockRoverApp < MarsRoverApplication

  attr_reader :content

  def initialize(file_name)
    @file = File.open(file_name)
    @content = read_content
    close_file
  end

end