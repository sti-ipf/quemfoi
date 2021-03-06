class Participant < ActiveRecord::Base
  belongs_to :course
  has_many :certificates
  has_many :activities_participants
  has_many :activities, :through => :activities_participants
# old schema
  # belongs_to :activity

  def self.get_names
    Participant.all(:select => 'name', :group => 'name').collect {|p| p.name.gsub("'","")}
  end

  def self.update_incorrect_participants(params={})
    name_condition = ''
    selected_names = params[:selected_names]
    course_id = params[:course_id].to_i
    correct_name = params[:correct_name]
    selected_names.each do |name|
      name_condition << "name = '#{name}'"
      name_condition << " OR " if name != selected_names.last
    end
    incorrect_participants = Participant.find_by_sql("
      SELECT * FROM participants p
      WHERE course_id = #{course_id}
      AND (#{name_condition})
    ")
    correct_participant = Participant.first(:conditions => "course_id = #{course_id} AND name = '#{correct_name}'")
    incorrect_participants.each do |p|
      if p.name != correct_participant.name
        ActiveRecord::Base.connection.execute("UPDATE activities_participants set participant_id = #{correct_participant.id} WHERE participant_id = #{p.id}")
        p.destroy
      end
    end
    correct_participant
  end

  def total_time(course_id)
    participant_total_time = 0
    activities_array = []
    self.activities.each do |a|
      if !activities_array.include?(a.id)
        activities_array << a.id
        participant_total_time += a.duration if a.course_id == course_id
      end
    end
    participant_total_time
  end

  def activities_numbers(an)
    numbers = []
    an.each do |n|
      if !self.list.nil?
        numbers << n if self.list.include?(n.to_s)
      end
    end
    return numbers.join(" ")
  end

  def frequency
    course = Course.find(self.course_id)
    participations = ActivitiesParticipant.all(:conditions => "participant_id = #{self.id}")
    activities_id = participations.collect(&:activity_id).join(',')
    activities = Activity.all(:conditions => "id IN (#{activities_id})")
    activities_time = 0
    activities.each do |a|
      activities_time += a.duration
    end

    percentage = (activities_time * 100)/course.total_hours
    if percentage > 100
      100
    else
      percentage
    end
  end

end

