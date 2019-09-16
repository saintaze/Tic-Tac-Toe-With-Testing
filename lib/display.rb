class Display
  attr_accessor :board

  def create_line_breaks(num); num.times {puts} end

  def display_header
    create_line_breaks(3)
    puts ("-" * 39).brown
    puts ("*" * 13).brown + " TIC-TAC-TOE ".brown + ("*" * 13).brown
    puts ("-" * 39).brown
    puts " " * 39
    puts ("-" * 16).cyan + " Rules ".cyan + ("-" * 16).cyan
  end

  def display_instructions 
    puts "Two players will take turns to mark the\nspaces on a 3x3 grid. The player who\nsucceeds in placing 3 of their marks in\na horizontal, vertical, or diagonal row\nwins the game. When there are no more\nspaces left to mark, it is considered a\ndraw. To place a mark on the grid, type\nthe number on the space you would like\nto mark! As shown below. Good luck! ".cyan
  end

  def draw_cells(cells_with_marks) 
    board_str = ""
    cells_with_marks.each_with_index do |q, i|
      if (i + 1) % 3 == 0
        board_str += " #{i+1} ".cyan if q.nil? 
        board_str += "   ".cyan if q
        board_str += "\n" + "---+---+---".cyan + "\n" if i < cells_with_marks.length - 1
      else
        board_str += " #{i+1} |".cyan if q.nil? 
        board_str += "   |".cyan if q
      end
    end
    puts board_str
  end

  def draw_cells_with_marks(cells_with_marks)
    board_str = ""
    cells_with_marks.each_with_index do |q, i|
      q = " #{q} ".gray_bg.red.bold if q == "X"
      q = " #{q} ".gray_bg.blue.bold if q == "O"
      q = "   ".gray_bg if q.nil?
      if (i + 1) % 3 == 0
        board_str += q + "\n"
        board_str += "---+---+---".gray_bg.black.bold + "\n" if i < cells_with_marks.length - 1
      else
        board_str += q + "|".gray_bg.black.bold
      end
    end
    puts board_str
  end

  def display_win_message(current_player)
    puts "Congrats!\n".blink_fast.cyan +  current_player.name.brown.bold + " you won the game!"; puts
    puts "game end".upcase
    true 
  end

  def display_draw_message
    puts "Game is Draw!".blink_slow.cyan
    true
  end

  def display_name_question(player)
    print player.brown.bold + ", what's your name ? "
  end

  def display_mark_selection_question(player)
    print player.name.brown.bold + " would you like to be " + "'O'".brown.bold + " or " + "'X'".brown.bold + " ? "
  end

  def display_selected_marks_message(p_1, p_2)
    puts p_1.name.brown.bold + " your mark is " + "'#{p_1.mark}'\n".brown.bold + p_2.name.brown.bold + " your mark is " + "'#{p_2.mark}'\n".brown.bold
  end

  def display_invalid_mark_message(player)
    puts player.name.brown.bold + " please select a correct mark " + "'O'".brown.bold + " or " + "'X'".brown.bold
  end

  def create_spot_unavailable_message(current_player, move)
    "Square ".italic + "'#{move}'".brown.bold + " is taken ".italic + current_player.name.brown.bold + ", select a number of an available square!".italic
  end

  def create_invalid_spot_message
    "Please select a valid empty square ".italic + "(1-9)".brown.bold
  end

  def display_restart_invalid_message
    puts "Please select a valid option ".italic + "(Y/N)".brown.bold
  end

  def display_game_begin_message 
    puts "let the game begin!".upcase.cyan; puts
  end

  def display_board_instruction_message
    puts "Board instructions to help you choose the square you want"
  end

  def display_player_turn_message(current_player)
    puts current_player.name.brown.bold + " it's your turn!" 
  end

  def display_spot_pick_question
    puts "Give me a number of an available square on the board! ".italic + "(1-9)".brown.bold 
  end

end