class Object
  # Creates a `#==` method for a class or module.
  #
  # Example:
  #
  # ```
  # class SomeClass
  #   @id : Int32
  #
  #   def initialize(@id)
  #   end
  #
  #   equalize({:id, :id})
  # end
  #
  # a = SomeClass.new(15)
  # b = SomeClass.new(15)
  # c = SomeClass.new(16)
  #
  # puts a == b # => true
  # puts b == c # => false
  # ```
  #
  # Using strict:
  #
  # ```
  # class Base
  #   @id : Int32
  #
  #   def initialize(@id)
  #   end
  #
  #   equalize({:id, :id}, strict: true)
  # end
  #
  # class SomeClass < Base
  #   equalize({:id, :id}, strict: true)
  # end
  #
  # a = Base.new(15)
  # b = SomeClass.new(15)
  #
  # puts a == b #=> false
  # ```
  macro equalize(*args, other_class = nil, strict = false)
    {{ other_class = other_class ? other_class.id : @type.id }}
    def ==(other : {{ other_class }})
      {% if strict %}
        return false unless other.class == {{ other_class }}
      {% end %}
      {% for arg in args %}
        return false unless {{ arg.first.id }} == other.{{ arg.last.id }}
      {% end %}
      true
    end
  end

  # Creates a method that mirrors an existing method.
  #
  # Example:
  #
  # ```
  # def send_tweet(text)
  #   puts text
  # end
  # alias_method :tweet, :send_tweet
  #
  # tweet("Hello world")
  # ```
  macro alias_method(new_name, existing_method)
    def {{ new_name.id }}(*args, **kwargs)
      {{ existing_method.id }}(*args, **kwargs)
    end
  end
end
