
require 'csv'

#CSV.parse("support/trips_optionals.csv") { |row1| puts row1.inspect }


trips = CSV.read('support/trips_optionals.csv')
trips[0] += ['cost', 'duration']
(1...trips.length).each do |count|
  duration = rand(120)
  cost = 0.50 * duration
  trips[count] += [cost,duration]
end

CSV.open('support/trips_optionals.csv', 'w') do |file|
  trips.each do |line|
    file << line
  end
end

# print trips[0]
# puts
# print trips[1]
# puts
# print trips[2]
# puts
# print trips[-1]
#CSV.open("support/trips_optionals.csv", )


#{:headers => true}
