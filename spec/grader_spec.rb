require 'rspec'
require 'grader'

describe 'Grader' do
  it "accepts ruby assessments" do
    Grader.create(:ruby, "", "", :json).should_not be_nil
  end
  
  it "fails this test purposely" do
    "test".should == ""
  end
  
  it "grades ruby assessments"
  
  # it "is an example of failing test" do
  #   "test".should == ""
  # end
  
end