class Certificate < ActiveRecord::Base
  belongs_to :participant
  belongs_to :course

  def save
    create_pdf_file
    fill_with_data
    @pdf_file.render_file(file_path)
  end

private

  def fill_with_data
    @pdf_file.draw_text participant.name, :at => [157,316], :size => 14
    @pdf_file.draw_text course.identifier, :at => [50,294], :size => 14
    @pdf_file.draw_text period, :at => [220,252], :size => 14
    @pdf_file.draw_text total_hours, :at => [547,252], :size => 14
    @pdf_file.draw_text frequency, :at => [678,252], :size => 14
    @pdf_file.draw_text I18n.localize(Time.now).split(',')[1], :at => [100,200], :size => 14
    @pdf_file.draw_text course.description, :at => [542,100], :size => 10
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

