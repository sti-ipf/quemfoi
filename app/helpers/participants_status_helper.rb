module ParticipantsStatusHelper

  def participant_frequency(time,total_time)
    total_time > 0 ? ((time/total_time.to_f)*100).floor : 0
  end

  def approved(time,total_time)
    (time/total_time)*100 > 75 ? 'Sim': 'Não'
  end
end

