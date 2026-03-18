require_relative 'Robot'
def radix(teams, metric, descending = true) 
  #INITITALIZATION
  teamsWithMetric = teams.map do |team|
    [team, (100 * (team.send(metric) || 0)).floor]
  end

  #SORTING
  # initialize buckets and begin with all elements in first bucket
  digit = 0
  while digit < 5
    buckets = Array.new(10) { [] }
    # for every element
    teamsWithMetric.each do |element|
      # extract current digit and put element in corresponding bucket
      currDigit = (element[1] / (10 ** digit)) % 10
      buckets[currDigit] << element
    end
    
    # update list and digit for next loop iteration
    teamsWithMetric = buckets.flatten(1)
    digit = digit + 1
  end  

  #GETTING RETURN
  sortedTeams = []
  teamsWithMetric.each_index do |i|
    sortedTeams[i] = teamsWithMetric[i][0]
    #equality handling
    if (i>0)
      if (sortedTeams[i] == sortedTeams[i-1]) and 
         (sortedTeams[i].number < sortedTeams[i-1].number)
            sortedTeams[i], sortedTeams[i-1] = sortedTeams[i-1], sortedTeams[i]
      end
    end
  end
  
  # putting return in correct order
  if descending
    sortedTeams.reverse!
  end
  return sortedTeams

end
