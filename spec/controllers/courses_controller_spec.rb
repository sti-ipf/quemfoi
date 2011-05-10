require 'spec_helper'

describe CoursesController do

  before(:each) do
    @course = Course.first
  end

  describe 'GET #new' do
    it 'instantiate a new course' do
      get :new
      assigns[:course].should be_a_kind_of(Course)
      response.should be_success
    end
  end

  describe 'GET #edit' do
    it 'assigns @course with course that it being edited' do
      get :edit, :id => @course.id
      assigns[:course].should == @course
      response.should be_success
    end
  end

  describe 'POST #create' do
    it 'saves course' do
      course = mock_model(Course).as_null_object
      Course.stub(:new).and_return(course)
      Course.should_receive(:new).with('identifier' => 'st01', 'description' => 'Software Testing course')
      post :create, :course => {'identifier' => 'st01', 'description' => 'Software Testing course'}
      flash[:notice].should eq("Formação criada com sucesso")
    end

    it 'error on saving course' do
      Course.stub(:save).and_return(:false)
      post :create
      response.should render_template("new")
    end
  end

  describe 'GET #index' do
    it 'assigns @courses with all courses' do
      Course.should_receive(:all).and_return(['an array'])
      get :index
      assigns[:courses].should == ['an array']
    end
  end

  describe 'PUT #update' do
    it 'updates course' do
      course = Course.new
      course.stub(:find).and_return(course)
      course.stub(:update_attributes).and_return(:true)
      put :update, :id => @course.id
      flash[:notice].should eq("Formação atualizada com sucesso")
    end

    it 'error on updating course' do
      course = Course.new
      Course.stub(:find).and_return(course)
      Course.stub(:update_attributes).and_return(:false)
      put :update, :id => @course.id
      response.should render_template("edit")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys course' do
      course = Course.new
      course.stub(:find).and_return(course)
      course.stub(:destroy).and_return(:true)
      put :destroy, :id => @course.id
      response.should redirect_to(courses_path)
    end
  end

  describe 'GET #show' do
    it 'show course' do
      course = Course.new
      course.stub(:find).and_return(course)
      put :show, :id => @course.id
      response.should render_template("show")
    end
  end

  describe 'GET #participants_status' do
    it 'get and render participants_status' do
      get :participants_status, :id => @course.id
      assigns[:course_total_time].should == @course.total_time
      response.should render_template("participants_status")
    end
  end

end

