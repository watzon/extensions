# Crystal Extensions

Lots of good ideas don't make it in to the Crystal standard library. This is a community controlled repository where those good ideas can live and become a part of other shards. Think of it as the Ruby communities [activesupport/core_ext](https://github.com/rails/rails/tree/master/activesupport/lib/active_support/core_ext), only for Crystal.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  extensions:
    github: watzon/extensions
```

## Documentation

### `Enumerable(T)`

#### `take(count : Int)`

Returns the first _n_ elements of an enumerable and returns an array with the results. Functionally the same as `first`, but `take` requires an argument.

### `Hash(K, V)`

#### `dig(*args)`

Extracts the nested value specified by the sequence of key objects by calling dig at each step, returning nil if any intermediate step is nil.

```crystal
hash = {"a" => {"b" => {"c" => "c"}}}

hash.dig("a", "b", "c")      # => "c"
hash.dig("a", "b", "c", "d") # => nil
```
#### `map_keys(&block)`

Returns a new hash with all keys converted using the block operation. The block can change a type of keys.

```crystal 
hash = {:a => 1, :b => 2, :c => 3}
hash.map_keys { |key| key.to_s } # => {"A" => 1, "B" => 2, "C" => 3}
```

#### `map_values(&block)`

Returns a new hash with the results of running block once for every value. The block can change a type of values.

```crystal
hash = {:a => 1, :b => 2, :c => 3}
hash.map_values { |value| value + 1 } # => {:a => 2, :b => 3, :c => 4}
```

#### `map_values!(&block)`

Destructively transforms all values using a block. Same as `map_values` but modifies in place. The block cannot change a type of values.

```crystal
hash = {:a => 1, :b => 2, :c => 3}
hash.map_values! { |value| value + 1 } # => {:a => 2, :b => 3, :c => 4}
```

### `Object`

#### `macro equalize(*args, other_class = nil, strict = false)`

Creates a `#==` method for a class or module.

Example:

```crystal
class SomeClass
  @id : Int32
  def initialize(@id)
  end
  equalize({:id, :id})
end

a = SomeClass.new(15)
b = SomeClass.new(15)
c = SomeClass.new(16)

puts a == b # => true
puts b == c # => false
```

Using strict:

```crystal
class Base
  @id : Int32
  def initialize(@id)
  end
  equalize({:id, :id}, strict: true)
end

class SomeClass < Base
  equalize({:id, :id}, strict: true)
end

a = Base.new(15)
b = SomeClass.new(15)

puts a == b #=> false
```

#### `macro alias_method(new_name, existing_method)`

Creates a method that mirrors an existing method.

Example:

```crystal
def send_tweet(text)
  puts text
end
alias_method :tweet, :send_tweet

tweet("Hello world")
```

## Contributing

1. Fork it ( https://github.com/watzon/extensions/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [watzon](https://github.com/watzon) Chris Watson - creator, maintainer
