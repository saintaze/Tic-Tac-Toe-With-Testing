require "board.rb"
require "player.rb"

describe Board do 
  let(:board) { Board.new }
  let(:display) { instance_double("Display") }
  let(:p_1) { Player.new }
  let(:p_2) { Player.new }
  let(:current_player) { p_1 }

  describe "#initialize" do 
    it "should create a Board instance" do
      expect(board).to be_an_instance_of(Board)
    end
  end

  describe "#validate_mark" do
    context "when the mark is neither X or O" do
      it "should display invalid mark message" do
        allow(display).to receive(:display_invalid_mark_message) { puts "John please select a correct mark 'O' or 'X'"}
        expect{ display.display_invalid_mark_message }.to output("John please select a correct mark 'O' or 'X'\n").to_stdout
      end
    end

    context "when the mark is either X or O" do
      it "should return nil" do
        allow(p_1).to receive(:mark).and_return("X")
        expect(board.validate_mark(p_1, display)).to be_nil
      end
    end
  end

  describe "#validate_spot_number" do
    context "when the input is invalid" do
      context "is taken" do
        it "should display spot taken message" do
          message = "Square 2 is taken John, select a number of an available square!"
          allow(display).to receive(:create_spot_unavailable_message) { puts message }
          expect { display.create_spot_unavailable_message }.to output( message + "\n" ).to_stdout
        end
      end

      context "is not a number" do
        it "should display spot invalid message" do
          allow(display).to receive(:create_invalid_spot_message) { puts "Please select a valid empty square (1-9)"}
          expect { display.create_invalid_spot_message }.to output("Please select a valid empty square (1-9)\n").to_stdout
        end
      end
    end 

    context "when the input is valid" do 
      it "should return the move" do
        expect(board.validate_spot_number(4, p_1, p_2, current_player, display)).to eq 4
      end
    end
  end
end