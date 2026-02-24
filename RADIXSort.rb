require_relative 'Robot'
def radix(teams, metric) 
  #INITITALIZATION
  teamsWithMetric = []
  teams.each_index do |i|
    # each team gets a tuple with the metric * 100 and then floored to handle decimal values
    teamsWithMetric << [teams[i], (100 * (teams[i].send(metric) || 0)).floor]
  end  

  #SORTING
  # initialize buckets and begin with all elements in first bucket
  oldBuckets = Array.new(10) { [] }
  oldBuckets[0] = teamsWithMetric
  digit = 1
  while digit <=5
    newBuckets = Array.new(10) { [] }
    # for every element in every bucket
    oldBuckets.each do |bucket|
      bucket.each do |element|
        # extract current digit and put element in corresponding bucket
        currDigit = element[1] % 10
        element[1] = element[1] / 10
        newBuckets[currDigit] << element
      end
    end
    # update buckets for next loop
    oldBuckets = newBuckets
    digit = digit + 1
  end  

  #GETTING RETURN
  sortedTeams = []
  teamsWithMetric.each_index do |i|
    sortedTeams[i] = teamsWithMetric[i][0]
    #equality handling
    if (i>0)
      if (teamsWithMetric[i][1] == teamsWithMetric[i-1][1]) and 
         (sortedTeams[i].number < sortedTeams[i-1].number)
            sortedTeams[i], sortedTeams[i-1] = sortedTeams[i-1], sortedTeams[i]
      end
    end
  end
  return sortedTeams
end
