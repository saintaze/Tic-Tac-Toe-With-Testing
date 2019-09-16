require "calc.rb"

describe Calc do
  context "when two values are added" do
    it "sums two values" do
      cacl = Calc.new
      expect(cacl.add(5, 11)).to eq(15)
    end
  end
end