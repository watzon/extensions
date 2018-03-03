class Hash(K, V)
  # Extracts the nested value specified by the sequence of key
  # objects by calling dig at each step, returning nil
  # if any intermediate step is nil.
  #
  # ```
  # hash = {"a" => {"b" => {"c" => "c"}}}
  # hash.dig("a", "b", "c")      # => "c"
  # hash.dig("a", "b", "c", "d") # => nil
  # ```
  def dig(*args : K)
    args.reduce(self) do |acc, i|
      if acc.responds_to?(:fetch)
        acc.fetch(i, nil)
      else
        nil
      end
    end
  end

  # Returns a new hash with all keys converted using the block operation.
  # The block can change a type of keys.
  #
  # ```
  # hash = {:a => 1, :b => 2, :c => 3}
  # hash.map_keys { |key| key.to_s } # => {"A" => 1, "B" => 2, "C" => 3}
  # ```
  def map_keys(&block : K -> K2) forall K2
    each_with_object({} of K2 => V) do |(key, value), memo|
      memo[yield(key)] = value
    end
  end

  # Returns a new hash with the results of running block once for every value.
  # The block can change a type of values.
  #
  # ```
  # hash = {:a => 1, :b => 2, :c => 3}
  # hash.map_values { |value| value + 1 } # => {:a => 2, :b => 3, :c => 4}
  # ```
  def map_values(&block : V -> V2) forall V2
    each_with_object({} of K => V2) do |(key, value), memo|
      memo[key] = yield(value)
    end
  end

  # Destructively transforms all values using a block. Same as map_values but modifies in place.
  # The block cannot change a type of values.
  #
  # ```
  # hash = {:a => 1, :b => 2, :c => 3}
  # hash.map_values! { |value| value + 1 }
  # hash # => {:a => 2, :b => 3, :c => 4}
  # ```
  def map_values!(&block : V -> V)
    current = @first
    while current
      current.value = yield(current.value)
      current = current.fore
    end
  end
end
