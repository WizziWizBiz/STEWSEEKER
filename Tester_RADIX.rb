require_relative 'Robot'
require_relative 'RADIXSort'

team2823 = Robot.new(2823, "The Automatons")
team2491 = Robot.new(2491, "No Mythic")
teams = [team2823, team2491]
teams[0].opr = 28.23
teams[1].opr = 24.91
teamsNum = radix(teams, :number)
teamsNum.each do |team|
  puts (team.name + ": " + team.number.to_s)
end  
teamsOpr = radix(teams, :opr)
teamsOpr.each do |team|
  puts (team.name + ": " + team.opr.to_s)
end  