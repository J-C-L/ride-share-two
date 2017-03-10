require 'csv'

# For optionals: adding cost and duration functionality.
#I did not write tests for this due to time constraints.

# Assigning random durations of 0 to 120 minutes, and using $0.50 per minute as trip cost.
# Writing a new trips_optionals.csv file, instead or re-writing the original trips.csv file.

trips = CSV.read('support/trips.csv')
trips[0] += ['cost', 'duration']

(1...trips.length).each do |count|
  duration = rand(120)
  cost = 0.50 * duration
  trips[count][5] = cost
  trips[count][6] = duration
end

CSV.open('support/trips_optionals.csv', 'w') do |file|
  trips.each do |line|
    file << line
  end
end
