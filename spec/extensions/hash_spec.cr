require "../spec_helper.cr"

describe Hash do
  describe "#dig" do
    it "digs into a hash and returns the correct value" do
      hash = {"a" => {"b" => {"c" => "d"}}}
      expect(hash.dig("a", "b", "c")).to eq("d")
    end

    it "returns nil if a value doesn't exist" do
      hash = {"a" => {"b" => {"c" => "d"}}}
      expect(hash.dig("a", "b", "c", "d")).to be_nil
    end

    it "doesn't raise an exception if multiple objects are nil" do
      hash = {"a" => {"b" => {"c" => "d"}}}
      expect(hash.dig("a", "b", "c", "d", "e", "f", "g")).to be_nil
    end
  end

  describe "#map_keys" do
    it "returns a new hash with transformed keys" do
      hash = {1 => "a", 2 => "b"}
      transformed = hash.map_keys(&.to_s)
      transformed.each do |key, _|
        expect(key).to be_a String
      end
    end

    it "doesn't modify the original hash" do
      hash = {1 => "a", 2 => "b"}
      transformed = hash.map_keys(&.to_s)
      expect(hash).to eq({1 => "a", 2 => "b"})
      expect(transformed).to eq({"1" => "a", "2" => "b"})
    end
  end

  describe "#map_values" do
    it "returns a new hash with transformed values" do
      hash = {:a => 1, :b => 2, :c => 3}
      transformed = hash.map_values(&.succ)
      expect(transformed).to eq({:a => 2, :b => 3, :c => 4})
    end

    it "doesn't modify the original hash" do
      hash = {:a => 1, :b => 2, :c => 3}
      transformed = hash.map_values(&.succ)
      expect(hash).to eq({:a => 1, :b => 2, :c => 3})
    end
  end

  describe "#map_values!" do
    it "modifies the values of an existing hash" do
      hash = {"a" => 1, "b" => 2, "c" => 3}
      hash.map_values!(&.succ)
      expect(hash).to eq({"a" => 2, "b" => 3, "c" => 4})
    end
  end
end
