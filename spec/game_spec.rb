require "game.rb"

describe Game do 
  let(:board) { instance_double("Board") } 
  let(:display) { instance_double("Display") }
  let(:p_1) { instance_double("Player") }
  let(:p_2) { instance_double("Player") }
  let(:game) { Game.new(board, display, p_1, p_2) }

  describe "#initialize" do
    it "should create a Game instance" do
      expect(game).to be_an_instance_of(Game)
    end 
  end

 
  describe "#play_again?" do
    context "when user presses 'Y' or 'y'" do
      it "should return true" do
        expect(game.play_again?("Y")).to be true
      end
    end

    context "when user presses 'N' or 'n'" do
      it "should return false" do
        expect(game.play_again?("N")).to be false
      end
    end

    context "when user presses invalid input" do
      it "should display restart invalid input message" do
        allow(display).to receive(:display_restart_invalid_message) {puts "Please select a valid option (Y/N)\n"}
        expect { game.display.display_restart_invalid_message }.to output("Please select a valid option (Y/N)\n").to_stdout
      end
    end
  end

  describe "#get_player_name" do 
    it "should set name to @name of the relevant player instance" do
      p_1.instance_variable_set(:@name, "John")
      expect(game.p_1.instance_variable_get(:@name)).to eq "John"
    end
  end

  describe "#get_player_mark" do
    context "when player 1" do
      it "should set mark to @mark of player 1" do
        p_1.instance_variable_set(:@mark, "X")
        expect(game.p_1.instance_variable_get(:@mark)).to eq "X"
      end
    end

    context "when player 2" do
      it "should set mark to @mark of player 2 to the opposite of player 1 mark" do
        p_2.instance_variable_set(:@mark, "O")
        expect(game.p_2.instance_variable_get(:@mark)).to eq "O"
      end
    end 
  end 

  describe "#game_draw?" do
    def setup_game_draw_test
      allow(display).to receive(:draw_cells_with_marks)
      allow(display).to receive(:display_draw_message)
    end

    context "when game draw" do
      it "should return true" do
        setup_game_draw_test
        allow(board).to receive(:cells_with_marks).and_return(Array.new(9, 1))
        expect(game.game_draw?).to be true
      end
    end

    context "when game not draw" do
      it "should return false" do
        setup_game_draw_test
        allow(board).to receive(:cells_with_marks).and_return(Array.new(9, nil))
        expect(game.game_draw?).to be false
      end
    end
  end
  
  describe "#game_won?" do
    def setup_game_won_test
      game.instance_variable_set(:@current_player, p_1)
      allow(display).to receive(:draw_cells_with_marks)
      allow(display).to receive(:display_win_message)
      allow(board).to receive(:cells_with_marks)
    end
  
    context "when game won" do
      it "should return true" do
        setup_game_won_test
        allow(p_1).to receive(:moves).and_return([1,2,3])
        expect(game.game_won?).to be true
      end
    end

    context "when game not won" do
      it "should return false" do
        setup_game_won_test
        allow(p_1).to receive(:moves).and_return([1,2,9])
        expect(game.game_won?).to be false
      end 
    end
  end 

  describe "#get_and_validate_player_move" do
    context "when input invalid" do
      context "and spot is not a number" do
        it "should display spot invalid message" do
        allow(display).to receive(:create_invalid_spot_message) { puts "Please select a valid empty square (1-9)\n" }
        expect { game.display.create_invalid_spot_message }.to output("Please select a valid empty square (1-9)\n").to_stdout 
        end
      end

      context "and spot is taken" do
        it "should display spot unavailable message" do
          message = "Square 3 is taken John select a number of an available square!"
          allow(display).to receive(:create_spot_unavailable_message) { puts message + "\n" }
          expect { game.display.create_spot_unavailable_message }.to output(message + "\n").to_stdout 
        end
      end
    end

    context "when input is valid" do
      it "should return the move" do
        allow(game).to receive(:gets).and_return("8\n")
        allow(board).to receive(:validate_spot_number).and_return(8)
        expect(game.get_and_validate_player_move).to eq 8
      end
    end
  end

  describe "#set_current_player" do 
    context "when player with turn is player-1" do
      it "should set @current_player to player-1" do
        game.instance_variable_set(:@current_player, p_1)
        expect(game.current_player).to eq p_1
      end
    end

    context "when player with turn is player-2" do
      it "should set @current_player to player-2" do
        game.instance_variable_set(:@current_player, p_2)
        expect(game.current_player).to eq p_2
      end
    end
  end

  describe "#playing_game" do
    context "when game is draw or game is won" do
      it "should end the game" do
        allow(game).to receive(:create_game_info_and_boards)
        allow(game).to receive(:get_and_validate_player_move)
        allow(game).to receive(:insert_mark_on_board)
        allow(game).to receive(:game_won?).and_return(true)
        expect(game.playing_game).to be_nil
      end
    end
    context "when game is not won or not draw" do
      it "should display board instructions message" do
        allow(display). to receive(:display_board_instruction_message) { puts "Board instructions to help you choose the square you want"}
        expect { game.display.display_board_instruction_message }.to output("Board instructions to help you choose the square you want\n").to_stdout
      end
    end 
  end

  describe "#start" do
    it "should start the game and display welcome header" do 
      allow(display).to receive(:display_header) { puts ("-" * 39) }
      expect { game.display.display_header }.to output(("-" * 39) + "\n").to_stdout
    end
  end

end  