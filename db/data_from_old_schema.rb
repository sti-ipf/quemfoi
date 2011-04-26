
    course = Course.create(:identifier => 'teste', :description => 'teste')
  

      activity = Activity.create(:name => 'adsdasda', :date => '2011-04-26', :place => 'adasdas',
        :leader => 'asdasdasd', :start_time => '2011-04-26 00:23:00 UTC', :end_time => '2011-04-26 01:23:00 UTC', :course => course)
    

          participant = Participant.create(:name => 'fadasdasdasd', :group => 'dasdasd', :unit => 'dasdasdas',
            :contact => 'dasdasd@dasdad.com.br')
        
ActivitiesParticipant.create(:activity => activity, :participant => participant)

      activity = Activity.create(:name => 'zczxczcz', :date => '2011-04-26', :place => 'zczczcz',
        :leader => 'zczczc', :start_time => '2011-04-26 00:31:00 UTC', :end_time => '2011-04-26 00:31:00 UTC', :course => course)
    
participant = Participant.find_by_name('fadasdasdasd')
ActivitiesParticipant.create(:activity => activity, :participant => participant)
