class Board
  attr_accessor :cells, :cells_with_marks

  def initialize
    @cells = (1..9).to_a
    @cells_with_marks = Array.new(9, nil)
  end

  def validate_mark(p_1, display)
    until p_1.mark == 'X' || p_1.mark == 'O'
      display.display_invalid_mark_message(p_1)
      p_1.mark = gets.chomp.upcase
    end
  end

  def validate_spot_number(move, p_1, p_2, current_player, display)
    spots = (1..9).to_a
    until spots.include?(move) && spot_available?(move, p_1, p_2)
      if spots.include?(move) || !spot_available?(move, p_1, p_2) 
        message = display.create_spot_unavailable_message(current_player, move)
      end
      if spot_available?(move, p_1, p_2) || !spots.include?(move)
        message = display.create_invalid_spot_message
      end
      puts message 
      move = gets.chomp.to_i
    end
    move
  end

  private

  def spot_available?(move, p_1, p_2)
    !p_1.moves.include?(move) && !p_2.moves.include?(move) && (1..9).include?(move)
  end

end