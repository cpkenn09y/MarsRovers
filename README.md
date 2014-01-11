# Mars Rover

Mars Rover that is able to accept commands and move around on a grid.


## Design Aspects:

From the beginning I knew that I wanted to make my code as modular as possible:

* Create a CommandParser that turned the user input into a usable format
* From there, create the Grid module that can have MarsRovers placed on it
* Create a MarsRover class that can maintain the state of each Rover and execute the provided commands
* Create an ApplicationController that uses the different modules like lego pieces to make the overall application run

* I constantly strived to keep each module as a separate entity with little to no intertwined dependencies
* Single responsibility and object oriented design were a very high priority for me throughout the project
* I wanted the code to be able scaleable and therefore made sure to only commit code that was extensively tested: TDD'd!
* Constantly built the next smallest thing until the whole application was realized.
* It was also important to me to create a visual representation that allowed the user to get visual feedback that the application was working

## Assumptions Made Along Way:

* The CommandParser would be a key component to the functionality of the application

* A scaleable MarsRover application would need to be able to have multiple rovers be instantiated and commanded

* I had initially thought that the value '5 5' would mean that I could easily represent the grid as an array with 25 units. However, I later realized that my Grid would have to represent the actual nodes meaning I would have to have 36 nodes.

As an illustration, I drew out a 3x3 box, made up of 9 small squares. I learned along the way that my initial design had to be reworked. Each array unit would have to represent the 12 nodes that compose the 3x3 box.

Once I restructured my code to encompass this change, it became possible to represent the rovers moving along the axes of my grid.

## To Run the Application:

1) From the Terminal, go into the folder containing all the files
2) Type the following code:
* ruby application.rb

Note: For funsies, open up application.rb and uncomment the lines of code specified at the bottom. It will run the program with three or eight rovers.

## To Run the 42 Tests:

1) From the Terminal, go into the folder containing all the files
2) Type the following code:
* rspec application_controller_spec.rb rover_command_parser_spec.rb grid_spec.rb mars_rover_spec.rb

