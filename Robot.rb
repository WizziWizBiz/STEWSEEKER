class Robot
  name = ""
  number = 0000
  matches = []
  opr = 0.0
  expectedScore = 0.0
  autoScore = 0.0
  teleScore = 0.0
  endgameScore = 0.0

  def initialize(number, name = "")
    @number = number
    if name == ""
      #TODO: fetch name from TBA API
    else
      @name = name
    end
    @matches = []
    @expectedScore = 0.0
    @autoScore = 0.0
    @teleScore = 0.0
    @endgameScore = 0.0
  end

  def matches
    @matches
  end

  #set matches to an array of unique match numbers, then sorts it
  def insertAllMatches(matches)
    @matches = matches
    @matches.sort!
  end

  # adds new match to the end of matches, then inserts it into the existing sorted matches
  # returns 0 if sorted correctly into matches
  # returns -1 if new match was a duplicate and not added to list
  def insertNewMatch(newMatch)
    @matches << newMatch
    return sortNewMatch
  end

  # does work of sorting a new match into the existing matches
  private def sortNewMatch
    matchesSize = @matches.size
    newMatch = @matches[matchesSize-1]

    if matchesSize < 2
      return 0 #only one element, no sorting needed
    else
      (matchesSize-2).downto(0) do |i| #loop from second-to-last index to first index
        if @matches[i] == @matches[i+1]
          @matches.delete_at(i+1) #duplicate added, remove it
          return -1 #TODO: raise error
        elsif @matches[i] > @matches[i+1]
          @matches[i], @matches[i+1] = @matches[i+1], @matches[i] # swap elements
        else
          return 0 # in correct place in the list
        end
      end
      return 0 # item had to be put in the front of the list
  end end

  attr_reader :name, :number, :matches, :opr, :expectedScore, :autoScore, :teleScore, :endgameScore

  #sets opr to new value
  def opr=(newOpr)
    @opr = newOpr
  end

  #TODO: pulls opr from TBA API
  def setOprTBA
    @opr = 0.0
  end 

  # sets total expected score based on subcomponents
  private def setExpectedScore
    @expectedScore = @autoScore + @teleScore + @endgameScore
  end

  # sets autonomous period score and updates total
  def autoScore=(newAutoScore)
    @autoScore = newAutoScore
    setExpectedScore
  end

  # sets teleop period score and updates total
  def teleScore=(newTeleScore)
    @teleScore = newTeleScore
    setExpectedScore
  end

  # sets engame score and updates total
  def endgameScore=(newEndScore)
    @endgameScore = newEndScore
    setExpectedScore
  end

end
