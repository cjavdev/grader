require 'rspec'
require 'ruby_grader'

class Grader  
  attr_accessor :specs, :solution, :report, :pass_count, :fail_count, :error_count
  
  ROOT_DIR      = "devfiltr"
  SOLUTION_DIR  = "lib"
  SOLUTION_NAME = "solution"
  SPEC_DIR      = "spec"
  SPEC_NAME     = "solution_spec"
  
  def self.create(type, specs, solution)
    setup_tree
    save_spec_file(specs)
    save_sol_file(solution)

    case type
    when :ruby
      RubyGrader.new(specs, solution)
    when :js
      JsGrader.new(specs, solution)
    end
  end
  
  def grade
    raise "Not implemented"
  end
  
  private
  def initialize(specs, solution)
    @specs = specs
    @solution = solution
    @pass_count = 0
    @fail_count = 0
    @error_count = 0
  end
  
  def self.setup_tree 
    unless Dir.exists?(ROOT_DIR)
      Dir.mkdir(ROOT_DIR)
    end
    
    [SOLUTION_DIR, SPEC_DIR].each do |dir|
      unless Dir.exists?(ROOT_DIR + "/" + dir)
        Dir.mkdir(ROOT_DIR + "/" + dir)
      end
    end
  end
  
  def self.save_spec_file(specs)
    path =[ROOT_DIR, SPEC_DIR, SPEC_NAME].join("/")
    File.open(path + @lang_ext, "w") do |f|
      req = "require_relative '../#{SOLUTION_DIR}/#{ SOLUTION_NAME }'"
      unless specs.index(req)
        f.puts req
      end
      f.puts specs
    end
  end
  
  def self.save_sol_file(solution)
    path = [ROOT_DIR, SOLUTION_DIR, SOLUTION_NAME].join("/")
    File.open(path + @lang_ext, "w") do |f|
      f.puts solution
    end
  end
end

