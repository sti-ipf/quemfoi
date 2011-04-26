
    course = Course.create(:identifier => 'sdasdas', :description => 'dasdasd')
  

      activity = Activity.create(:name => 'adasdsad', :date => '2011-04-26', :place => 'adsasdsad',
        :leader => 'dasdasdas', :start_time => '2011-04-26 01:14:00 UTC', :end_time => '2011-04-26 02:14:00 UTC', :course => course)
    

          participant = Participant.create(:name => 'dasdasd', :group => 'dasdasd', :unit => 'dasdsad',
            :contact => 'asd', :course => course)
        
ActivitiesParticipant.create(:activity => activity, :participant => participant)

      activity = Activity.create(:name => 'czxczxczxc', :date => '2011-04-26', :place => 'xczczxc',
        :leader => 'xczxczx', :start_time => '2011-04-26 01:22:00 UTC', :end_time => '2011-04-26 02:22:00 UTC', :course => course)
    
participant = Participant.find_by_name('dasdasd')
ActivitiesParticipant.create(:activity => activity, :participant => participant)
