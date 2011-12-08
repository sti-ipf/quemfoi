class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.xml
  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id], :include => [ :activities ])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
      format.csv do
        @activities = Activity.to_csv_file(@course.activities)
        @filename = 'atividades.csv'
        @output_encoding = 'UTF-8'
      end
    
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => t(:course_created) ) }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])
    params[:course][:total_hours] = params[:course][:total_hours].gsub(',', '.')
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(courses_path, :notice => t(:course_updated) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end

  def participants_status
    @course = Course.find(params[:id])
    @participants = @course.participants_info
    @course_total_time = @course.total_time
    respond_to do |format|
      format.html
    end
  end

  def participants
    @activities = Course.find(params[:id]).activities
    @activities_numbers = []
    @activities.each do |a|
      if !a.identificator_number.nil?
        @activities_numbers << a.identificator_number.gsub(' ', '')
      end
    end

  end

  def update_list
    participant = Participant.find(params[:id])
    participant.list = params[:list]
    participant.save
  end
end

