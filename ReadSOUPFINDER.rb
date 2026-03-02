require 'csv' 
require_relative 'Robot'
def parseTestData 
    leng = CSV.read("SOUPFINDER_Test_Data.csv").length
    teams = Array.new(leng-1)
    i = 0
    CSV.foreach("SOUPFINDER_Test_Data.csv", headers: true) do |row|
        number = row["team #"].to_i
        teams[i] = Robot.new(number)
        teams[i].autoScore = row["auto"].to_i
        teams[i].teleScore = row["tele"].to_i
        teams[i].endgameScore = row["endgame"].to_i
        i += 1
    end
    return teams
end
