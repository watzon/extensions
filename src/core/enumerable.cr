module Enumerable(T)
  # Returns the first _n_ elements of an enumerable and returns
  # an array with the results.
  def take(count : Int)
    raise ArgumentError.new("Attempt to take negative size") if count < 0

    array = Array(T).new
    each_with_index do |e, i|
      array << e if i < count
    end
    array
  end
end
