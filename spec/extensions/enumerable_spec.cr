require "../spec_helper"

describe Enumerable do
  describe "#take" do
    it "takes the first n elements of an enumerable" do
      arr = [1, 2, 3, 4, 5]
      first_3 = arr.take(3)
      expect(first_3.size).to eq(3)
      expect(first_3).to eq([1, 2, 3])
    end

    it "takes the full array if n is greater than the array's size" do
      arr = [1, 2, 3, 4, 5]
      all = arr.take(8)
      expect(all.size).to eq(5)
      expect(all).to eq([1, 2, 3, 4, 5])
    end

    it "raises an exception if n is a negative number" do
      arr = [1, 2, 3, 4, 5]
      expect { arr.take(-5) }.to raise_error(Exception, "Attempt to take negative size")
    end
  end
end
