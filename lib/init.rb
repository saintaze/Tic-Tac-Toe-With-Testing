require_relative "board.rb"
require_relative "game.rb"
require_relative "display.rb"
require_relative "player.rb"
require_relative "string_color.rb"

$p_1, $p_2, $display, $board, $game = nil, nil, nil, nil, nil

def instantiate_classes
  $p_1 = Player.new
  $p_2 = Player.new
  $display = Display.new
  $board = Board.new
  $game = Game.new($board, $display, $p_1, $p_2) 
end

def replay(play_again)
  puts "Want to play again? ".italic + "(Y/N)".brown.bold
  option = gets.chomp.upcase
  unless $game.play_again?(option)
    puts "Thanks for playing! Hope to see you again!".cyan.bold
    return false
  end
  true
end

def init_game 
  play_again = true
  while play_again
    instantiate_classes
    $game.start; puts
    play_again = replay(play_again)
  end
end




