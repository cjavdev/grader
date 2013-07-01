require 'rspec'

class Grader  
  attr_accessor :example_count, :failure_count, :pending_count
  attr_accessor :specs, :solution, :report, :format
  
  ROOT_DIR      = "devfiltr"
  SOLUTION_DIR  = "lib"
  SOLUTION_NAME = "solution"
  SPEC_DIR      = "spec"
  SPEC_NAME     = "solution_spec"
  
  def self.create(type, specs, solution, format = :html)
    setup_tree
    
    case type
    when :ruby
      RubyGrader.new(specs, solution, format)
    when :js
      JsGrader.new(specs, solution, format)
    end
  end
  
  def grade
    raise "Not implemented"
  end
  
  private
  def initialize(specs, solution, format)
    @format = format
    @specs = specs
    @solution = solution
    @example_count = 0
    @failure_count = 0
    @pending_count = 0
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
  
  def save_spec_file(specs)
    path =[ROOT_DIR, SPEC_DIR, SPEC_NAME].join("/")
    File.open(path + @lang_ext, "w") do |f|
      req = "require_relative '../#{SOLUTION_DIR}/#{ SOLUTION_NAME }'"
      unless specs.index(req)
        f.puts req
      end
      f.puts specs
    end
  end
  
  def save_sol_file(solution)
    path = [ROOT_DIR, SOLUTION_DIR, SOLUTION_NAME].join("/")
    File.open(path + @lang_ext, "w") do |f|
      f.puts solution
    end
  end
end

require 'stringio'

class RubyGrader < Grader 
  attr_accessor :lang_ext
  
  def initialize(specs, solution, format)
    @lang_ext = ".rb"

    save_spec_file(specs)
    save_sol_file(solution)
    
    super(specs, solution, format)
  end
  
  def grade
    config = RSpec.configuration
    config.output_stream = StringIO.new #File.open('test.html', 'w')
    config.formatter = @format
    path = [Grader::ROOT_DIR, Grader::SPEC_DIR].join("/")
    puts "path: " + path
    RSpec::Core::Runner::run(['devfiltr'])
    @example_count = config.formatters.first.example_count
    puts "example count " +  @example_count.to_s
    @failure_count = config.formatters.first.failure_count
    puts "failure count " + @failure_count.to_s
    @pending_count = config.formatters.first.pending_count  
    puts "pending count " + @pending_count.to_s           
    @report = config.output_stream.string
    p config
    self                
  end
end


