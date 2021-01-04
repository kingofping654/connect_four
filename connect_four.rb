puts "Hello, and welcome to Connect Four! In this game you will race against the computer to get 4 spots marked with your color tokens. You can do this either left to right, up and down, or diagonally. Keep in mind this is a 7 x 6 board and you can't go into other collumns when going up and down or other rows when going left and right. To get started type connect = ConnectFour.new('your name here','either red or yellow')\nconnect.start_game.\n\n"

class ConnectFour

  #This method begins the class and creates the board, decides the computers color based on the players color choice, and chooses the computers name based on a list of famous pop culture computers. The player also can optionally choose a name and color which are defualted to player 1 and red respectively.
    def initialize(player="Player 1", color = 'Red')
        @player = player
        @computer = ["Hal", "Kit", "Bat-Computer", "Karen", "NICOLE", "Glados", "Bishop", "EDI", "Cortana", "Guilty Spark", "John Henry Eden", "ADA", "Dummy Plug", "Shodan", "Jarvis", "The Magi", "Sigma", "SARA", "Lappy-486", "Stem", "Ava", "Samantha"].sample
        @board = create_board
        @color = color
        @computer_color = computer_color
        @red = false
        @yellow = false
    end

  #A method that creates the array the game board is based off of. As its a 6x7 board it has 42 spaces to choose from (0-41).
    def create_board
    board = []
    x = 0
    until x > 41
            board.push([x])
            x += 1
        end
        board
    end

 #This method decides what color the computer is based on if the player chose to be red or yellow.    
def computer_color
    player = @color
if player == "Red"
    computer = 'Yellow'
elsif player == 'Yellow'
        computer = 'Red'
    end
    computer
end

#A method to play out the computers turn. It essentially just picks a random open spot on the board and lays its token. The spot must be either in the bottom row or have a token below it. The board is then updated to reflect this choice. I could add some logic to this to make the computer a bit better at playing but for now the computer is picking at total random.
def computers_turn
@choice = (0..42).to_a.sample
#until @board[@choice] != 'Red' && @board[@choice] != 'Yellow' 
until @board[@choice + 7] == 'Red' || @board[@choice + 7] == 'Yellow' || @choice > 34 && @board[@choice] != 'Red' && @board[@choice] != 'Yellow'
@choice = (0..42).to_a.sample
#end
end
@board[@choice] = computer_color
end

#Method exists to display the board so that the player knows how everything looks.
def display_board
    print @board
    @board
end

#The player is prompted for a space to puts his/her token. If they choose a space that doesn't exist or is already occupied. They are asked to choose again until they pick somehting acceptable. The chosen spot must also either be in the bottom row or have a token below it. The board is then updated with the selected spot being replaced with the players color.
def players_turn
print "\n#{@board}\n"
puts "\nwhich open spot would you like to choose(type the number of the space you want and press enter\n"
@choice = gets.chomp.to_i
until @board[@choice + 7] == 'Red' || @board[@choice + 7] == 'Yellow' || @choice > 34 && @board.include?(@board[@choice]) && @board[@choice - 7] != Array && @board[@choice] != 'Red' && @board[@choice] != 'Yellow'
puts 'Your chosen spot needs to be on the board, not already occupied, and either in the bottom row(35-41) or already have a token below it.'
@choice = gets.chomp.to_i
end
@board[@choice] = @color
@board
end

#A simple coin flip method that randomly picks heads or tails and based on the players choice they either get to go first or not.
def who_goes_first
    puts "To decide who goes first we will flip a coin. Heads or Tails?\n"
    choice = gets.chomp.downcase
    
    until choice == "heads" || choice == 'tails'
        puts "\nLook just type heads or tails and hit enter so we can get started.\n"
        choice = gets.chomp.downcase
    end
    coin = ['heads','tails'].sample

    if coin == choice
      puts "\nNice, you got it right that means you're up first!\n"  
      player_1 = true
    else
      puts "\nLooks like you guesed wrong that means #{@computer} goes first.\n"
        player_1 = false
    end
    player_1
end

#A simple check for if one of the players has won the game based on 4 vertical tokens. It starts at 0 and increases by 7 each turn till it goes beyond 41 where it goes to the next column and starts the process again. Each turn if the space is red or yellow it adds 1 to the yellow or red counter and returning the opposite counter to 0. If the spot is blank both counters revert to 0. The method stops when the board has been gone through or yellow/red get 4 spaces in a row. If yellow/red get 4 in a row the win condition for that color is chosen by turning @red or @yellow equal to true. 
def game_over_up_down
red = 0
yellow = 0
marker = 0
column = 0
until column > 6    
until marker > 41
break if red == 4
break if yellow == 4
        if @board[marker] == 'Red'
    red += 1
    yellow = 0
    marker += 7
      elsif @board[marker] == 'Yellow'
    yellow += 1
    red = 0
    marker += 7
      else
        yellow = 0
        red = 0
        marker += 7
end
end
break if red == 4
break if yellow == 4
column += 1
red = 0
yellow = 0
marker = column
end
if red == 4 
    @red = true
elsif yellow == 4
  @yellow = true
else
end
end

#A simple check for if one of the players has won the game based on 4 to the right diagonally tokens. It starts at the last players chosen spot and increases by 8 each turn till it goes beyond 41. if 4 in a row is not achieved the counter resets and checker goes back to the last players chosen spot and subtracts by 8 till it goes below 0. Each turn if the space is red or yellow it adds 1 to the yellow or red counter and returning the opposite counter to 0. If the spot is blank both counters revert to 0. The method stops when the possible options have been gone through or yellow/red get 4 spaces in a row. If yellow/red get 4 in a row the win condition for that color is chosen by turning @red or @yellow equal to true. 
def game_over_diagonal_right
red = 0
yellow = 0
marker = @choice
until marker > 41
  break if red == 4
  break if yellow == 4
  if @board[marker] == 'Red'
    red += 1
    yellow = 0
    marker += 8
  elsif @board[marker] == 'Yellow'
    yellow += 1
    red = 0
    marker += 8
  else
    red = 0
    yellow = 0
    marker += 8
  end
end
  if red == 4
    @red = true
  elsif yellow == 4
    @yellow = true
  end
marker = @choice
until marker < 0
  break if red == 4
  break if yellow == 4
  if @board[marker] == 'Red'
    red += 1
    yellow = 0
    marker -= 8
  elsif @board[marker] == 'Yellow'
    yellow += 1
    red = 0
    marker -= 8
  else
    yellow = 0
    red = 0
    marker -= 8
  end
end
if red == 4
    @red = true
  elsif yellow == 4
    @yellow = true
  end
end

#A simple check for if one of the players has won the game based on 4 to the left diagonally tokens. It starts at the last players chosen spot and increases by 6 each turn till it goes beyond 41. if 4 in a row is not achieved the counter resets and checker goes back to the last players chosen spot and subtracts by 6 till it goes below 0. Each turn if the space is red or yellow it adds 1 to the yellow or red counter and returning the opposite counter to 0. If the spot is blank both counters revert to 0. The method stops when the possible options have been gone through or yellow/red get 4 spaces in a row. If yellow/red get 4 in a row the win condition for that color is chosen by turning @red or @yellow equal to true. 
def game_over_diagonal_left
red = 0
yellow = 0
marker = @choice
until marker > 41
  break if red == 4
  break if yellow == 4
  if @board[marker] == 'Red'
    red += 1
    yellow = 0
    marker += 6
  elsif @board[marker] == 'Yellow'
    yellow += 1
    red = 0
    marker += 6
  else
    red = 0
    yellow = 0
    marker += 6
  end
end
  if red == 4
    @red = true
  elsif yellow == 4
    @yellow = true
  end
marker = @choice
until marker < 0
  break if red == 4
  break if yellow == 4
  if @board[marker] == 'Red'
    red += 1
    yellow = 0
    marker -= 6
  elsif @board[marker] == 'Yellow'
    yellow += 1
    red = 0
    marker -= 6
  else
    yellow = 0
    red = 0
    marker -= 6
  end
end
if red == 4
    @red = true
  elsif yellow == 4
    @yellow = true
  end
end

#A simple check for if one of the players has won the game based on 4 horizontal tokens. It starts at 0 and increases by 1 each turn till it goes to the end of the row where it goes to the next row and starts the process again. Each turn if the space is red or yellow it adds 1 to the yellow or red counter and returning the opposite counter to 0. If the spot is blank both counters revert to 0. The method stops when the board has been gone through or yellow/red get 4 spaces in a row. If yellow/red get 4 in a row the win condition for that color is chosen by turning @red or @yellow equal to true. 
def game_over_left_right
red = 0
yellow = 0
marker = 0
row_starter = 0
until row_starter > 35
  break if red == 4
  break if yellow == 4
until marker > row_starter + 6
    break if red == 4
    break if yellow == 4
    if @board[marker] == 'Red'
        red += 1
        yellow = 0
        marker += 1
    elsif @board[marker] == 'Yellow'
        yellow += 1
        red = 0
        marker += 1
    else 
      yellow = 0
      red = 0
      marker += 1
      end
end
break if red == 4
break if yellow == 4
row_starter += 7
red = 0
yellow = 0
marker = row_starter
end
if red == 4 
    @red = true
elsif yellow == 4
  @yellow = true
end
end

#This method exists to collect all of the game over methods together so they can be used together at once without clogging up the start_method.
def game_over_collection_hd
  game_over_diagonal_left
  game_over_diagonal_right
  game_over_left_right
  game_over_up_down
end

#The main method to run the game. It begins with the who_goes_first method to decide on who goes first. Based on that method the player or the computer goes first and the appropriate method is used to run that action. After each move the game_over_collection mehtod is used to test if the move results in a player winning. If it does the game is broken if not the next player goes and the cycle repeats. Once a winner is decided or the board fills up a message is triggered and the player is asked if they would like to play again. If they choose yes a new game is started if no the game is ended.
def start_game
first = who_goes_first
if first == true
    until @red == true || @yellow == true
        players_turn
        game_over_collection_hd
        break if @red == true 
        break if @yellow == true
        computers_turn
        game_over_collection_hd
    end
else
    until @red == true || @yellow == true
        computers_turn
        game_over_collection_hd
        break if @yellow == true
        break if @red == true 
        players_turn 
        game_over_collection_hd
    end
end

if @red == true
  puts "Congratulations #{@player} you won! Do you want a rematch? (yes/no)"
  rematch = gets.chomp.downcase
elsif @yellow == true
  puts "Congrats #{@computer} you won! #{@player} do you want a rematch? (yes/no)"
  rematch = gets.chomp.downcase
  else
    puts "Huh I guess no one wins... Want to play again? (yes/no)"
    rematch = gets.chomp.downcase
end

if rematch == 'yes'
    new_game = ConnectFour.new(@player, @color)
    new_game.start_game
end
end

end


connect = ConnectFour.new

connect.start_game