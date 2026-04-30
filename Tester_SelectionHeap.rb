require_relative 'Robot'
require_relative 'SelectionHeap'
require_relative 'RADIXSort'
require_relative 'ReadSOUPFINDER'

# get all team info
teams = parseTestData

# sort by team number
teams = radix(teams, :number)

@autoHeap = SelectionHeap.new(teams, :autoScore)
@teleHeap = SelectionHeap.new(teams, :teleScore)
@endHeap = SelectionHeap.new(teams, :endgameScore)

def printHeaps()
  puts("Best Auto: #{@autoHeap.peek()}\nBest Tele: #{@teleHeap.peek()}\nBest Endgame: #{@endHeap.peek()}")
end

def removeEach(number)
  p(@autoHeap.removeNode(number))
  p(@teleHeap.removeNode(number))
  p(@endHeap.removeNode(number))
end

printHeaps()
removeEach(4009)
printHeaps()
removeEach(93)
printHeaps()
removeEach(4741)
printHeaps()
removeEach(1816)
printHeaps()
