require_relative "Robot"

# Exception for attempting to remove a team that doesn't exist
class NodeDoesntExist < StandardError
end

class HeapNode
  attr_reader :bot, :score
  attr_accessor :index

  def initialize(robot, metric)
    @bot = robot
    @score = robot.send(metric) || 0
    #store index within each node to preserve hash map lookup efficiency
    @index = -1
  end
end

class SelectionHeap
  
  hashmap = Hash.new
  # heap is now level-order array
  heap = [nil]
  metric = nil
  
  #metric to organize the heap by and teams (sorted by number?) are expected to create the heap from
  def initialize(teams, metric)
    @metric = metric
    heap = Array.new(1)
    teams.each_index do |teamsAlready|
      node = HeapNode.new(teams[teamsAlready], @metric) 
      addNode(node, teamsAlready)
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
    
    return heapRemove(node.index)
  end

  # returns the team and score at the top of the heap as a tuple. returns nil if the heap is empty
  def peek()
    (@heap[0] == nil) ? (return nil) : (return [@heap[0].team, @heap[0].score])
  end

  private

  # adds a node to the hash map and heap
  def addNode(node, numOthers)
    node.index = numOthers # corresponds to place in array
    # Add to hash map
    @hashmap[node.bot.number] = node
    # Special case for first node in heap
    if (@heap[0] == nil)
      @heap[0] = node
    else
      @heap << node
      reheapifyUp()
    end
  end

  # helper function to handle removing things from the hashmap
  def hashMapRemove(number)
    ret = Hash.delete(number) # will return the node that corresponds to the number if found, or nil if not found
    if (ret == nil)
      raise NodeDoesntExist, "Team with number #{number} not found in the heap"
    else return ret
  end
  
  # Helper to remove node from heap after getting it from the hash table. Returns (bot, score) of removed node 
  def heapRemove(index)
    heapSwap(index, @heap.length-1)
    removedNode = @heap.pop() # removes last node from array and the space for it in the array
    
    if (@heap.length != 0)
      reheapifyDown(index)
    else 
      # preserve state of what an empty heap is
      @heap << nil
    end

    return [removedNode.team, removedNode.score]
  end  

  # Helper to swap the position of two nodes within the heap
  def heapSwap(iOne, iTwo)
    if (iOne >= @heap.length)
      raise NodeDoesntExist, "There isn't a(n) #{iOne}'th node in the heap"
    elsif (iTwo >= @heap.length)
      raise NodeDoesntExist, "There isn't a(n) #{iTwo}'th node in the heap"
    else
      @heap[iOne].index = iTwo
      @heap[iTwo].index = iOne

      @heap[iOne], @heap[iTwo] = @heap[iTwo], @heap[iOne]
    end
  end
   

  # reheapification for adding the given node (assumes >=2 nodes in heap)
  def reheapifyUp()
    index = -1
    parentIndex = (index - 1) / 2
    if (@heap[index].score > @heap[parentIndex].score)
      heapSwap(index, parentIndex)
      if (parentIndex != 0)
        reheapifyUp(parentIndex)
      end
    end
    return nil
  end

  #reheapification for removing the given node
  def reheapifyDown(index)
    # Check for no children
    begin
      leftIndex = 2 * index + 1
    rescue IndexError => e
      return nil
    end

    # Check for only left child
    begin
      rightIndex = 2 * index + 2
    rescue IndexError => e
      if (@heap[index].score > @heap[leftIndex].score)
        heapSwap(index, leftIndex)
        # no other swap will be needed because it's a complete tree
      end
      return nil
    end

    # find maximum child score
    if (@heap[leftIndex].score > @heap[rightIndex].score)
      max = leftIndex
    else
      max = rightIndex
    end

    # check if swap is needed, recursive call to keep restoring tree
    if (@heap[index].score > @heap[max].score)
      heapSwap(index, leftIndex)
      reheapifyDown(max)
    else
      return nil
    end

  end
  end

end