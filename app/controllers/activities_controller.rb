# -*- coding: utf-8 -*-
class ActivitiesController < ApplicationController

  # GET /activities/new
  # GET /activities/new.xml

  before_filter :load_data, :except => [:index, :show]

  def new
    @course = Course.find(params[:course_id])
    @javascript_hash = @course.participants_as_javascript_hash
    @activity = @course.activities.build
    80.times { @activity.participants.build }
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @activity = Activity.find(params[:id])
    20.times { @activity.participants.build }
    @javascript_hash = @course.participants_as_javascript_hash
  end

  # POST /activities
  # POST /activities.xml
  def create
    @course = Course.find(params[:course_id])
    @activity = @course.activities.build(params[:activity])
    @participants = @activity.participants.collect
    @activity.participants = []
    respond_to do |format|
      if @activity.save
        save_participants
        format.html { redirect_to( course_path(params[:course_id]), :notice => 'Lista de presença salva com sucesso') }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        @javascript_hash = @course.participants_as_javascript_hash
        80.times { @activity.participants.build }
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.xml
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to( course_path(params[:course_id]), :notice => 'Lista de presença salva com sucesso') }
        format.html { redirect_to(@activity, :notice => 'activity was successfully updated.') }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.xml
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(course_path(params[:course_id])) }
      format.xml  { head :ok }
    end
  end

  def load_data
    @courses = Course.all.collect{|c| [c.identifier, c.id]}
  end

  def update_formation
    activity = Activity.find(params[:id])
    activity.formation = params[:formation]
    activity.save
  end

  def save_participants
    @participants.each do |p|
      participant = Participant.first(:conditions => {:name => p.name, :contact => p.contact, :course_id => p.course_id})
      if participant.nil?
puts "-" * 100
        puts Participant.count
        puts "-" * 100
        p = Participant.create(p.attributes)
        puts "-" * 100
        puts Participant.count
        puts "-" * 100
        ActivitiesParticipant.create(:activity_id => @activity.id, :participant_id => p.id)
      else
        ActivitiesParticipant.create(:activity_id => @activity.id, :participant_id => participant.id)
      end
      puts "-" * 100
        puts Participant.count
        puts "-" * 100
    end
  end
end

