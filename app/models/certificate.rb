class Certificate < ActiveRecord::Base
  belongs_to :participant
  belongs_to :course

  def save_file
    create_pdf_file
    fill_with_data
    @pdf_file.render_file(file_path)
  end

  def period
    "#{self.course.start_date.try(:strftime, '%d/%m/%Y')} - #{self.course.end_date.try(:strftime, '%d/%m/%Y')}"
  end

private

  def fill_with_data
    course_description = format_course_description
    @pdf_file.draw_text participant.name, :at => [157,316], :size => 12
    @pdf_file.draw_text course.identifier_to_certificate, :at => [50,294], :size => 12
    @pdf_file.draw_text period, :at => [220,252], :size => 12
    @pdf_file.draw_text total_hours, :at => [547,252], :size => 12
    @pdf_file.draw_text frequency, :at => [678,252], :size => 12
    @pdf_file.draw_text I18n.localize(Time.now).split(',')[1], :at => [100,200], :size => 12
    y_position = 100
    course_description.each do |description|
      @pdf_file.draw_text description, :at => [545,y_position], :size => 6
      y_position -= 10 
    end
  end
  
  def format_course_description
    course_description = course.description 
    description_size = course_description.size
    if description_size > 40
      array = [] 
      string = ""
      break_control = 0
      course_description_splitted = course_description.split(" ")
      course_description_splitted.each do |description|
        if (break_control + description.size) > 70
          array << string
          break_control = 0
          string = ""
          string << "#{description} "
        else 
          string << "#{description} "
        end
        break_control += description.size
      end
      array << string
    else
      [course_description]
    end
  end

  def create_pdf_file
    @pdf_file = Prawn::Document.new(:template => "#{RAILS_ROOT}/lib/certificate/certificado_pec_ementa.pdf")
    @pdf_file.font_families.update(
        "pt sans" => {:normal => "#{RAILS_ROOT}/public/fonts/PT_Sans-Regular.ttf",
                      :bold => "#{RAILS_ROOT}/public/fonts/PT_Sans-Bold.ttf",
                      :italic => "#{RAILS_ROOT}/public/fonts/PT_Sans-Italic.ttf",
                      :bolditalic => "#{RAILS_ROOT}/public/fonts/PT_Sans-BoldItalic.ttf"
                      })
    @pdf_file.font "pt sans"
  end

end

