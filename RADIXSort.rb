require_relative 'Robot'
def radix(teams, metric) 
  #INITITALIZATION
  teamsWithMetric = []
  teams.each_index do |i|
    # each team gets a tuple with the metric * 100 and then floored to handle decimal values
    teamsWithMetric << [teams[i], (100 * (teams[i].send(metric) || 0)).floor]
  end  
  #SORTING

  #GETTING RETURN
  sortedTeams = []
  teamsWithMetric.each_index do |i|
    sortedTeams[i] = teamsWithMetric[i][0]
    if (i>0)
      if (teamsWithMetric[i][1] == teamsWithMetric[i-1][1]) and 
         (sortedTeams[i].number < sortedTeams[i-1].number)
            sortedTeams[i], sortedTeams[i-1] = sortedTeams[i-1], sortedTeams[i]
      end
    end
  end
  return sortedTeams
end

