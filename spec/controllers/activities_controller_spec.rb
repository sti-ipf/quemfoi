require 'spec_helper'

describe ActivitiesController do

  fixtures :activities, :participants, :courses, :activities_participants

  before(:each) do
    @course = Course.find_by_identifier('ruby01')
    @course_activity = @course.activities.first
    @participants = @course_activity.participants
    @new_activity_hash  = {'name' => "Brand new activity", 'course_id' => @course.id,
                      'date' => Date.tomorrow, 'start_time' => DateTime.now + 1.day,
                      'end_time' => DateTime.now + 1.day + 2.hours, 'place' => "IPF"}
  end

  describe 'GET #new' do
    it 'instantiate a new activity and 80 new participants' do
      get :new, :course_id => @course.id
      assigns[:activity].should be_a_kind_of(Activity)
      assigns[:course].should == @course
      assigns[:activity].participants == 80
      assigns[:javascript_hash].should_not be_nil
      response.should be_success
    end
  end

  describe 'GET #edit' do
    it 'assigns @course with course that it being edited' do
      get :edit, :course_id => @course.id, :id => @course_activity.id
      assigns[:course].should == @course
      assigns[:activity].should == @course_activity
      assigns[:activity].participants == 20 + @participants.count
      assigns[:javascript_hash].should_not be_nil
      response.should be_success
    end
  end

  describe 'POST #create' do
    it 'saves activity' do
      course = mock_model(Course).as_null_object
      activity = mock_model(Activity).as_null_object
      course.activities.stub(:build).and_return(activity)
      Activity.stub(:save).and_return(:true)
      post :create, :course_id => @course.id, :id => @course_activity.id, :activity => @new_activity_hash
      flash[:notice].should eq("Lista de presença salva com sucesso")
    end

    it 'error on saving activity' do
      Activity.stub(:save).and_return(:false)
      post :create, :course_id => @course.id, :id => @course_activity.id
      response.should render_template("new")
    end
  end

  describe 'PUT #update' do
    it 'updates activity' do
      activity = Activity.new
      Activity.stub(:find).and_return(activity)
      activity.stub(:update_attributes).and_return(:true)
      put :update, :course_id => @course.id, :id => @course_activity.id
      flash[:notice].should eq("Lista de presença salva com sucesso")
    end

    it 'error on updating activity' do
      activity = Activity.new
      Activity.stub(:find).and_return(activity)
      Activity.stub(:update_attributes).and_return(:false)
      put :update, :course_id => @course.id, :id => @course_activity.id
      response.should render_template("edit")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys activity' do
      activity = Activity.new
      activity.stub(:find).and_return(activity)
      activity.stub(:destroy).and_return(:true)
      put :destroy, :course_id => @course.id, :id => @course_activity.id
      response.should redirect_to(course_path(@course.id))
    end
  end

end

