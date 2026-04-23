require_relative "Robot"

# Exception for attempting to remove a team that doesn't exist
class NodeDoesntExist < StandardError
end

class HeapNode
  attr_reader :bot, :score

  def initialize(robot, metric)
    @bot = robot
    @score = robot.send(metric) || 0
  end
end

class SelectionHeap
  
  hashmap = Hash.new
  # heap is now level-order array
  heap = nil
  metric = nil
  
  #metric to organize the heap by and teams (sorted by number?) are expected to create the heap from
  def initialize(metric, teams)
    @metric = metric
    heap = Array.new(len(teams))
    teams.each_index do |i|
      node = HeapNode.new(teams[i], @metric) 
      addNode(node, i)
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
    (@heap[0] == nil) ? (return nil) : (return (@heap[0].team, @heap[0].score))
  end

  private

  # adds a node to the hash map and heap
  def addNode(node, numOthers)
    @hashmap[node.bot.number] = node
    # TODO: add to heap itself
  end

  # helper function to handle removing things from the hashmap
  def hashMapRemove(number)
    ret = Hash.delete(number) # will return the node that corresponds to the number if found, or nil if not found
    if (ret == nil)
      raise NodeDoesntExist, "Team with number #{number} not found in the heap"
    else return ret
  end
  
  # Helper to remove node from heap after getting it from the hash table. Returns (bot, score) of removed node 
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