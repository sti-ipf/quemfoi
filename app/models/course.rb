class Course < ActiveRecord::Base
  has_many :activities, :dependent => :destroy
  has_many :participants, :dependent => :destroy
  has_many :certificates, :dependent => :destroy
# old schema
  # has_many :activities
  validates_presence_of :identifier

  scope :certificates_not_generated, where(:certificates_generated => false)

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
      start_date = a.date if start_date.nil? || a.date < start_date
    end
    start_date
  end

  def end_date
    end_date = nil
    activities.each do |a|
      end_date = a.date if end_date.nil? || a.date > end_date
    end
    end_date
  end

  def participants_info
    info_about_participants = []
    participants.each do |p|
      info_about_participants << [p, p.total_time(self.id)]
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

