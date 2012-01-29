$: << File.expand_path(File.dirname(__FILE__))
require 'node'

class LruCache

  def initialize(max_size)
    @max_size = max_size
    @nodes = {}
    @head = @tail = nil
  end

  def size
    @nodes.size
  end

  def get(key)
    return nil unless @nodes.has_key? key
    
    node = @nodes[key]
    # move the item to the head
    remove node
    attach_to_head node

    node.data
  end

  def put(key, data)
    if @nodes.has_key? key   
      # cache update
      node = @nodes[key]
      node.data = data
      remove node
      attach_to_head node
    else  
      # new item
      node = Node.new(key, data)
      @nodes[key] = node
      attach_to_head node

      if size > @max_size && !@tail.nil?
        @nodes.delete @tail.key
        remove @tail # remove LRU item
      end
    end
  end

  def delete(key) 
    return unless @nodes.has_key? key

    remove @nodes[key]  #remove from linked list
    @nodes.delete key   #remove from hash
  end

  private 

  def attach_to_head(node)
    node.next = @head
    @head.prev = node unless @head.nil?
    @head = node
    @tail = node if @tail.nil?
  end

  def remove(node)
    node.prev.next = node.next unless node.prev.nil?
    node.next.prev = node.prev unless node.next.nil?
    @tail = node.prev if node == @tail
  end
  
end
