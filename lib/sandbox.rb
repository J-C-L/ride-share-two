require 'csv'

trips = CSV.read('support/trips_optionals.csv')
puts trips.parse_line(0)
# For optionals, adding cost and duration to the trips.csv file.
# Assigning random durations of 0 to 120 minutes, and using $0.50 per minute as trip cost.
# trips = CSV.read('support/trips.csv')
# trips[0] += ['cost', 'duration']
#
# (1...trips.length).each do |count|
#   duration = rand(120)
#   cost = 0.50 * duration
#   trips[count][5] = cost
#   trips[count][6] = duration
# end
#
#
# CSV.open('support/trips_optionals.csv', 'w') do |file|
#   trips.each do |line|
#     file << line
#   end
# end
