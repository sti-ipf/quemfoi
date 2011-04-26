class Course < ActiveRecord::Base
  has_many :activities
  has_many :participants
  has_many :certificates

  validates_presence_of :identifier

  def total_time
    total_time = 0
    activities.each do |a|
      total_time += a.duration
    end
    total_time
  end

  def start_date
    start_date = nil
    activities.each do |a|
      start_date = a.start_time if start_date.nil? || a.start_time < start_date
    end
    start_date
  end

  def end_date
    end_date = nil
    activities.each do |a|
      end_date = a.end_time if end_date.nil? || a.end_time > end_date
    end
    end_date
  end

  def participants_info
    info_about_participants = []
    participants.each do |p|
      participant_total_time = 0
      p.activities.each do |a|
        participant_total_time += a.duration
      end
      info_about_participants << [p, participant_total_time]
    end
    info_about_participants
  end

  def participants_as_javascript_hash
    javascript_hash = "["
    participants.each do |p|
      if participants.last.id != p.id
        javascript_hash << "{name: '#{p.name}', group: '#{p.group}', unit: '#{p.unit}', contact: '#{p.contact}'},"
      else
        javascript_hash << "{name: '#{p.name}', group: '#{p.group}', unit: '#{p.unit}', contact: '#{p.contact}'}"
      end
    end
    javascript_hash << "]"
  end

end

