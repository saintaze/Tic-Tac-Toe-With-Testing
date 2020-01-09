 class Game 

  attr_accessor :current_player, :p_1, :p_2
  attr_reader :win_comb, :board, :display

  def initialize(board, display, p_1, p_2)
    @board = board
    @display = display
    @p_1 = p_1
    @p_2 = p_2
    @current_player = nil
    @win_comb = [
      [1,2,3],
      [4,5,6],
      [7,8,9],
      [1,4,7],
      [2,5,8],
      [3,6,9],
      [1,5,9],
      [3,5,7]
    ]
  end

  def start
    display.display_header
    display.display_instructions
    init_player_info
    display.display_game_begin_message
    @current_player = p_1
    playing_game
  end

  def play_again?(option)
    until option == 'Y' || option == 'N'
      display.display_restart_invalid_message
      option = gets.chomp.upcase
    end
    option == 'Y'
  end

  # private 

  def init_player_info
    display.create_line_breaks(2)
    display.display_name_question("Player 1")
    get_player_name(p_1)
    display.display_mark_selection_question(p_1)
    get_player_mark("p_1")
    board.validate_mark(p_1, display)
    display.display_name_question("Player 2")
    get_player_name(p_2); puts
    get_player_mark("p_2")
    display.display_selected_marks_message(p_1, p_2)
  end

  def get_player_name(player)
    player.name = gets.chomp.capitalize
  end

  def get_player_mark(player)
    if player == "p_1"
      p_1.mark = gets.chomp.upcase 
    else
      p_2.mark = p_1.mark == 'X' ? "O" : "X"
    end
  end

  def set_current_player
    self.current_player = current_player.object_id == p_1.object_id ? p_2 : p_1
  end

  def game_draw?
    if board.cells_with_marks.none? {|cell| cell.nil?}
      puts; display.draw_cells_with_marks(board.cells_with_marks); puts
      display.display_draw_message
      return true
    end
    false
  end

  def game_won? 
    win_comb.each do |comb|
      comb_found = comb.all? {|val| self.current_player.moves.include?(val)}
      if comb_found
        puts; display.draw_cells_with_marks(board.cells_with_marks); puts
        display.display_win_message(current_player)
        return true
      end 
    end
    false
  end

  def get_and_validate_player_move
    move = gets.chomp.to_i; puts
    move = board.validate_spot_number(move, p_1, p_2, current_player, display)
    move
  end

  def insert_mark_on_board(move)
    board.cells_with_marks[move - 1] = current_player.mark
    current_player.moves << move
  end

  def create_game_info_and_boards
    display.display_board_instruction_message; puts
    display.draw_cells(board.cells_with_marks);
    display.create_line_breaks(3) 
    display.draw_cells_with_marks(board.cells_with_marks); puts
    display.display_player_turn_message(current_player); puts
    display.display_spot_pick_question; puts
  end

  def playing_game
    while true
      create_game_info_and_boards
      move = get_and_validate_player_move
      insert_mark_on_board(move)
      break if game_won? || game_draw?
      set_current_player
    end
  end
  
end

