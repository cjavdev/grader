require 'rspec'
require 'grader'

describe 'Grader' do
  it "accepts ruby assessments" do
    Grader.create(:ruby, "", "").should_not be_nil
  end
  it "grades ruby assessments"
end