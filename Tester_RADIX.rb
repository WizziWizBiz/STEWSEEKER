require_relative 'Robot'
require_relative 'RADIXSort'
require_relative 'ReadSOUPFINDER'
'''
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
'''

teams = parseTestData
#teams.each do |team|
  #puts(team.number)
#end
puts "----- TELE SCORE -----"
teamsTele = radix(teams, :teleScore)
teamsTele.each do |team|
  print(team.number,  " ", team.teleScore, "\n")
end
puts "----- AUTO SCORE -----"
teamsAuto = radix(teams, :autoScore)
teamsAuto.each do |team|
  print(team.number,  " ", team.autoScore, "\n")
end
puts "----- END SCORE -----"
teamsEnd = radix(teams, :endgameScore)
teamsEnd.each do |team|
  print(team.number, " ", team.endgameScore, "\n")
end