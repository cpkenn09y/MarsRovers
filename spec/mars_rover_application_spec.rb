require_relative 'spec_helper'

describe "MarsRoverApplication" do

user_input =
"5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM"

  context "Initialize:" do
    it "accepts a text file as an argument" do
      argv_stub = ["TW_input.txt"]
      mock_rover = MockRoverApp.new(argv_stub[0])
      expect(mock_rover.content).to eq(user_input)
    end
  end

  context "Run:" do
    it "executes the program and returns an array of rover final positions" do
      argv_stub = ["3_rovers.txt"]
      my_app = MockRoverApp.new(argv_stub[0])
      expect(my_app.run!).to eq(["1 2 S", "1 3 N", "4 1 N"])
    end
  end

end