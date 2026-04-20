require_relative "Robot"
require "Hash"

# Exception for attempting to remove a team that doesn't exist
class NodeDoesntExist < StandardError
end

class HeapNode
  attr_reader :bot, :score
  attr_accessor :left, :right, :parent

  def initialize(robot, metric, parent=nil, left=nil, right=nil)
    @bot = robot
    @score = robot.send(metric) || 0
    @left = left
    @right = right
    @parent = parent
  end
end

class SelectionHeap
  
  hashmap = Hash.new
  heapRoot = nil
  metric = nil
  
  #metric to organize the heap by and teams (sorted by number?) are expected to create the heap from
  def initialize(metric, teams)
    @metric = metric
    teams.each_index do |i|
      node = HeapNode.new(teams[i], @metric) 
      addNode(node)
    end
  end

  # removes a team from the heap and hash map, returning its score. Will return nil if an error occurs while removing the node.
  def removeNode(number)
    # Try to remove node from hash table
    begin
      node = hashMapRemove(number)
    rescue NodeDoesntExist => e
      puts "#{e.message}"
      return nil
    end
    
    return heapRemove(node)
  end

  # returns the team and score at the top of the heap as a tuple. returns nil if the heap is empty
  def peek()
    (heapRoot == nil) ? (return nil) : (return (heapRoot.team, heapRoot.score))
  end

  private
  # Given a team number, finds the corresponding node in the hash map and returns it. returns nil if not found
  # I think this is redundant? may be removed later
  def lookup(number)
    return @hashmap[number]
  end

  # adds a node to the hash map and heap
  def addNode(node)
    @hashmap[node.robot.number] = node
    # TODO: add to heap itself
  end

  # helper function to handle removing things from the hashmap
  def hashMapRemove(number)
    ret = Hash.delete(number) # will return the node that corresponds to the number if found, or nil if not found
    if (ret == nil)
      raise NodeDoesntExist, "Team with number #{number} not found in the heap"
    else return ret
  end
  
  # Helper to remove node from heap after getting it from the hash table. 
  def heapRemove(node)
    return nil
  end  

  # reheapification for adding the given node
  def reheapifyUp(node)
    return nil
  end

  #reheapification for removing the given node
  def reheapifyDown(node)
    return nil
  end
  end

end