class Robot
  name = ""
  number = "0000"
  matches = []
  opr = 0.0
  excpectedscore = 0.0
  autoscore = 0.0
  telescore = 0.0
  endgamescore = 0.0

  def initialize(number, name = "")
    @number = number
    if name == ""
      #TODO: fetch name from TBA API
    else
      @name = name
    end
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

    if @matchesSize < 2
      return #only one element, no sorting needed
    
    
    (matchesSize-2).downto(0) do |i| #loop from second-to-last index to first index
      if @matches[i] == @matches[i+1]
        @matches.delete_at(i+1) #duplicate added, remove it
        return -1
      elsif @matches[i] > @matches[i+1]
        @matches[i], @matches[i+1] = @matches[i+1], @matches[i] # swap elements
      else
        return 0 # in correct place in the list
      end
    end

    return 0 # item had to be put in the front of the list
  end end

  # returns opr
  def opr
    @opr
  end

  #sets opr to new value
  def opr=(newOpr)
    @opr = newOpr
  end

  #TODO: pulls opr from TBA API
  def setOprTBA
    @opr = 0.0
  end 

  # returns expected score
  def expectedScore
    @excpectedscore
  end

  # sets total expected score based on subcomponents
  private def setExpectedScore
    @excpectedscore = @autoscore + @telescore + @endgamescore
  end

  # returns auto score
  def autoScore
    @autoscore
  end

  # sets autonomous period score and updates total
  def autoScore=(newAutoScore)
    @autoscore = newAutoScore
    setExpectedScore
  end

  # returns teleop score
  def teleScore
    @telescore
  end

  # sets teleop period score and updates total
  def teleScore=(newTeleScore)
    @telescore = newTeleScore
    setExpectedScore
  end

  # returns endgame score
  def endgameScore
    @endgamescore
  end

  # sets engame score and updates total
  def endgameScore=(newEndScore)
    @endgamescore = newEndScore
    setExpectedScore
  end

  # returns team name
  def name
    @name
  end

  # returns team number
  def number
    @number
  end

end
