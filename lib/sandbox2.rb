

require 'csv'
  filepath = "support/drivers.csv"
  #classtype = Driver
  args_keys = [:id, :name, :vin]
  args = {}

  all_instances =[]
  CSV.foreach(filepath, {:headers => true}) do |line|
    args_keys.each do |key|
      args[key] = line[args_keys.index(key)]
    end
    puts args
      #all_instances << classtype.new(args)
  end
