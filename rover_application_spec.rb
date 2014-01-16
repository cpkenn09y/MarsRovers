require 'rspec'
require_relative 'rover_application'

describe "RoverApplication" do
  context "Initialization:" do
    it "accepts a text file as an argument" do
      argv_stub = ["thoughtworks_input.txt"]
      my_app = RoverApplication.new(argv_stub)
      expect(my_app.file).to eq(argv_stub[0])
    end
  end
end

# case ARGV[0]
# when nil
#   f = File.open("thoughtworks_input.txt")
#   user_input = f.read
#   f.close

#   ApplicationController.parse_and_execute(user_input)
# when "application_controller_spec.rb"
# else
#   f = File.open(ARGV[0])
#   user_input = f.read
#   f.close

#   ApplicationController.parse_and_execute(user_input)
# end