require 'rspec'
require 'grader'
require 'ruby_grader'

describe 'Grader' do
  it "accepts ruby assessments" do
    Grader.create(:ruby, "", "", :json).should_not be_nil
  end
  it "grades ruby assessments"
end