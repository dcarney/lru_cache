class Node
  attr_accessor :prev, :next, :data, :key

  def initialize(key, data)
    @prev = @next = nil
    @key = key
    @data = data
  end
  
end
