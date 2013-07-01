require 'stringio'

class RubyGrader < Grader 
  attr_accessor :lang_ext
  
  def initialize(specs, solution)
    @lang_ext = ".rb"
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