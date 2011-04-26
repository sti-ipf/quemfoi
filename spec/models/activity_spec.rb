require 'spec_helper'

describe Activity do

  fixtures :activities, :participants, :courses, :activities_participants

  before(:each) do
    @ruby_course = courses(:ruby)
    @ruby_activity = activities(:activity_one)
    @new_activity  = Activity.new(:name => "Brand new activity",
                      :date => Date.tomorrow, :start_time => DateTime.now + 1.day,
                      :end_time => DateTime.now + 1.day + 2.hours, :place => "IPF")
  end

  def activity_without_property_should_be_invalid(property)
    a = @new_activity
    eval("a.#{property} = nil")
    a.should_not be_valid
    a.errors[property.to_sym].should_not be_nil
  end

  it 'has many participants' do
    @ruby_activity.participants.count.should >= 1
  end

  it 'belongs to one course' do
    @ruby_activity.course.should_not be_nil
  end

  it 'requires presence of name' do
    activity_without_property_should_be_invalid('name')
  end

  it 'requires presence of date' do
    activity_without_property_should_be_invalid('date')
  end

  it 'requires presence of start_time' do
    activity_without_property_should_be_invalid('start_time')
  end

  it 'requires presence of end_time' do
    activity_without_property_should_be_invalid('end_time')
  end

  it 'requires presence of place' do
    activity_without_property_should_be_invalid('place')
  end

  it 'rejects participant if his name is blank' do
    activity = Activity.create(:name => "Create Hello World App", :date => Date.tomorrow,
                :start_time => "Thu, 21 Apr 2011 13:00:00 -0300",
                :end_time => "Thu, 21 Apr 2011 14:00:00 -0300", :place => "IPF", :course_id => @ruby_course,
                :participants_attributes =>
                {"0" => {:name => "João", :course_id => @ruby_course}, "1" => {:name => "", :course_id => @ruby_course}})
    activity.participants.count.should == 1
  end

  describe 'duration' do
    it 'return 1 when activity duration has 1 duration' do
      @ruby_activity.save
      @ruby_activity.duration.should == 1
    end
  end

end

