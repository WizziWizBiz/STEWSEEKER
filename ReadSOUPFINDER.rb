require 'csv' 
require_relative 'Robot'
def parseTestData 
    leng = CSV.read("SOUPFINDER_Test_Data.csv").length
    teams = Array.new(leng-1)
    i = 0
    CSV.foreach("SOUPFINDER_Test_Data.csv", headers: true) do |row|
        number = row["team #"].to_i
        teams[i] = Robot.new(number)
        teams[i].autoScore = row["auto"].to_f.round(2)
        teams[i].teleScore = row["tele"].to_f.round(2)
        teams[i].endgameScore = row["endgame"].to_f.round(2)
        i += 1
    end
    return teams
end
