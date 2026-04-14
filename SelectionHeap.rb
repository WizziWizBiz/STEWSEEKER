require_relative "Robot"
class SelectionHeap
  
  hashmap = Array.new[100000] #HOW TO DO HASHMAP?????
  heapRoot = nil
  metric = nil
  
  #metric to organize the heap by and teams (sorted by number?) are expected to create the heap from
  def initialize(metric, teams)
    @metric = metric
    teams.each_index do |i|
      node = HeapNode.new(teams[i], @metric) 
      # add node to heap (and to hashmap but thats probably going to be done in the heap add function)
    end
  end

  # removes a node fron heap and hash map, returning its value
  def removeNode(number)
    return nil
  end

  private
  # Given a team number, finds the corresponding node in the hash map and returns it. returns nil if not found
  def lookup(number)
    return nil
  end

  # adds a node to the hash map and heap
  def addNode(node)
    return nil
  end
  # helper function to handle adding things to the hash map
  def hashMapAdd(node) 
    return nil
  end
  # helper function to handle removing things from the hashmap
  def hashMapRemove(number)
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
