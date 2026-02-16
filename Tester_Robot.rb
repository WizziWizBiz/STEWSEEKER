require_relative 'Robot'

def test_robot
  puts "=== Creating Robot ==="
  robot = Robot.new(2823, "The Automatons")

  puts "Number test: #{robot.number == 2823 ? 'PASS' : 'FAIL'}"
  puts "Name test: #{robot.name == 'The Automatons' ? 'PASS' : 'FAIL'}"

  puts "\n=== Testing Match Insertion ==="
  robot.insertAllMatches([5, 2, 9])
  puts "Sorted matches test: #{robot.matches == [2,5,9] ? 'PASS' : 'FAIL'}"

  result = robot.insertNewMatch(7)
  puts "Insert new match test: #{robot.matches == [2,5,7,9] ? 'PASS' : 'FAIL'}"

  result = robot.insertNewMatch(7)
  puts "Duplicate match rejection test: #{result == -1 ? 'PASS' : 'FAIL'}"

  puts "\n=== Testing OPR ==="
  robot.opr = 35.5
  puts "OPR setter/getter test: #{robot.opr == 35.5 ? 'PASS' : 'FAIL'}"

  puts "\n=== Testing Score Components ==="
  robot.autoScore = 10
  robot.teleScore = 20
  robot.endgameScore = 15

  puts "Auto score test: #{robot.autoScore == 10 ? 'PASS' : 'FAIL'}"
  puts "Tele score test: #{robot.teleScore == 20 ? 'PASS' : 'FAIL'}"
  puts "Endgame score test: #{robot.endgameScore == 15 ? 'PASS' : 'FAIL'}"
  puts "Expected score calculation test: #{robot.expectedScore == 45 ? 'PASS' : 'FAIL'}"

  puts "\n=== All tests complete ==="
end

test_robot