require './lib/grader.rb'


my_specs = File.read("spec/grader_spec.rb")
my_solution = File.read("lib/grader.rb")

p Grader.create(:ruby, my_specs, my_solution, :documentation).grade
