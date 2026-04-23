require_relative "Robot"

# Exception for attempting to remove a team that doesn't exist
class NodeError < StandardError
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
    (@heapRoot == nil) ? (return nil) : (return [@heapRoot.bot, @heapRoot.score])
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
      raise NodeError, "Team with number #{number} not found in the heap"
    else return ret
    end
  end
  
  # Helper to remove node from heap after getting it from the hash table. 
  def heapRemove(node)
    return nil
  end  

  # given a parent node and its child, swaps their position within the heap
  def swapNodes(par, child)
    # find if child is the left or right child
    if par.left == child
      isLeft = true
    elsif par.right == child
      isLeft = false
    else
      raise NodeError, "SWAPNODES expected (parent, child) but did not get a parent and child"
    end

    # check if parent is the root node
    if heapRoot != par
      child.parent = par.parent
    else
      @heapRoot = child
    end

    # Manage swap based on leftness or rightness
    if isLeft
      cRight = child.right
      child.right = par.right
      par.left = child.left
      par.right = cRight
      child.left = par
    else
      cLeft = child.left
      child.left = par.left
      par.left = cLeft
      par.right = child.right
      child.right = par
    end

    par.parent = child
  end

  # reheapification for adding the given node. Node already placed within tree, it just needs to be moved.
  def reheapifyUp(node)
    # Node has been added somewhere in the heap
    if node != @heapRoot
      if node.score > node.parent.score
        swapNodes(node.parent, node)
        reheapifyUp(node)
      end
    end
    return nil
  end

  #reheapification for removing the given node. The removed node is already gone, this rearranges after putting new node in "root"
  def reheapifyDown(node)
    if (node.left != nil) && (node.right != nil)
      # both children exist, find max between them and test for swap
      maxScore = max(node.left.score, node.right.score)
      if node.score < maxScore
        if maxScore == node.left.score
          swapTarg = node.left
        else
          swapTarg = node.right
        end
        swapNodes(node, swapTarg)
        reheapifyDown(node)
      end
    elsif node.left != nil
      # only left child exists, test it for swap
      if node.score < node.left.score
        swapNodes(node, node.left)
        reheapifyDown(node)
      end
    elsif node.right != nil
      # only right cild exists, test it for swap
      if node.score < node.right.score
        swapNodes(node, node.right)
        reheapifyDown(node)
      end
    end
    # either no swap is needed or a node is a leaf
    return nil
  end

end