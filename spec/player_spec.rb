require "player.rb"

describe Player do 
  let(:player) { Player.new }

  describe "#initialize" do
    it "should create a player instance" do 
      expect(player).to be_an_instance_of(Player)
    end

    it "should set @name to ''" do
      expect(player.name).to eq ""
    end

    it "should set @mark to ''" do
      expect(player.mark).to eq ""
    end

    it "should set @moves to []" do
      expect(player.moves).to eq([])
    end
  end

  describe "#name" do
    it "should return @name" do 
      expect(player.name).to eq(player.name)
    end
  end

  describe "#mark" do
    it "should return @mark" do 
      expect(player.mark).to eq(player.mark)
    end
  end

   describe "#moves" do
    it "should return @moves" do 
      expect(player.moves).to eq(player.moves)
    end
  end

end