# Mars Rover

Mars Rover that is able to accept commands and move around on a grid.


## Design Aspects:

From the beginning I knew that I wanted to make my code as modular as possible:

* Create a CommandParser that turned the user input into a usable format
* From there, create the Grid module that can have MarsRovers placed on it
* Create a MarsRover class that can maintain the state of each Rover and execute the provided commands
* Create an ApplicationController that use the different modules like lego pieces to make the overall application run

* I constantly strived to keep each module as a separate entity with little to no intertwined dependencies
* Single responsibility and object oriented design were a very high priority for me throughout the project
* I wanted to code to be able to scaleable and therefore made sure to only commit code that was extensively tested: TDD'd!
* Constantly build the next smallest thing until the whole application is realized.
* It was also important to me to create a visual representation that allowed the user to get visual feedback that the application was working

## Assumptions Made Along Way:

* A scaleable MarsRover application would need to be able to have multiple rovers be commanded

* I had initially thought that the value '5 5' would mean that I could easily represent the grid as an array with 25 units. However, I later realized that my Grid would have to represent the actual coordinate-nodes meaning I would have to have 36 nodes.

As an illustration, I drew out a 3x3 box, made up of 9 small squares. I learned the hard way that the units of my array would not represent each square area, but had to instead represent the 12 nodes that compose the box. Once I restructured my code to encompass this change, it became possible to represent the rovers moving along the axes of my grid.

## To Run the Application:

1) From the Terminal, go into the folder containing all the files
2) Type the following code:
* ruby application.rb

Note: For funsies, open up application.rb and uncomment the lines of code specified at the bottom. It will run the program with three or eight rovers.

## To Run the 42 Tests:

1) From the Terminal, go into the folder containing all the files
2) Type the following code:
* rspec application_controller_spec.rb rover_command_parser_spec.rb grid_spec.rb mars_rover_spec.rb

