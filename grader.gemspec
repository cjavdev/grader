Gem::Specification.new do |s|
  s.name               = "grader"
  s.version            = "0.0.1"
  s.default_executable = "grader"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["CJ Avilla"]
  s.date = %q{2013-06-30}
  s.description = %q{A gem to grade code assessments using BDD packages}
  s.email = %q{cjavilla@gmail.com}
  s.files = ["Rakefile", "lib/grader.rb", "bin/grader"]
  s.test_files = ["spec/grader_spec.rb"]
  s.homepage = %q{http://rubygems.org/gems/grader}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Filter out Devs who can't code!}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

