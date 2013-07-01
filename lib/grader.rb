require 'rspec'
require 'stringio'

class Grader
  
  attr_accessor :specs, :solution, :report, :pass_count, :fail_count, :error_count
  
  ROOT_DIR      = "devfiltr"
  SOLUTION_DIR  = "lib"
  SOLUTION_NAME = "solution"
  SPEC_DIR      = "spec"
  SPEC_NAME     = "solution_spec"
  
  LANG_EXT = { :ruby => ".rb", :js => ".js" }
  
  def self.create(type, specs, solution)
    setup_tree
    File.open([ROOT_DIR, SPEC_DIR, SPEC_NAME].join("/") + LANG_EXT[type], "w") do |f|
      req = "require_relative '../#{SOLUTION_DIR}/#{ SOLUTION_NAME }'"
      unless specs.index(req)
        f.puts req
      end
      f.puts specs
    end
    
    File.open([ROOT_DIR, SOLUTION_DIR, SOLUTION_NAME].join("/") + LANG_EXT[type], "w") do |f|
      f.puts solution
    end
    
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
end

class RubyGrader < Grader 
  def initialize(specs, solution)
    super(specs, solution)
  end
  
  def grade
    config = RSpec.configuration
    config.output_stream = StringIO.new #File.open('test.html', 'w')
    config.formatter = :html

    RSpec::Core::Runner::run([[ROOT_DIR, SPEC_DIR].join("/")])
    @report = config.output_stream.string
  end
end
