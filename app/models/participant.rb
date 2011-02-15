class Participant < ActiveRecord::Base
  belongs_to :course

  def <=>(other)
    name <=> other.name
  end
end
