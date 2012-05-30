# encoding: utf-8

class Resume
  attr_accessor :name, :objective, :technologies, :experience, :academic_activities, :education

  def initialize(hash)
    self.name = hash.keys.first
    hash = hash[self.name]
    self.objective = hash["Objective"]
    self.technologies = hash["Technologies"]
    self.experience = hash["Experience"]
    self.academic_activities = hash["Academic Activities"]
    self.education = hash["Education"]
  end

  def to_pdf
    Prawn::Document.generate "/tmp/resume.pdf" do |pdf|
      pdf.move_down 40
      pdf_header(pdf, self.name)
      pdf.move_down 30
      pdf_objective(pdf, self.objective)
      pdf.move_down 20
      pdf_list_technologies(pdf, self.technologies)
      pdf.move_down 20
      pdf_list_experience(pdf, self.experience)
      pdf_list_academic_experience(pdf, self.academic_activities)
      pdf.move_down 20
      pdf_list_education(pdf, self.education)
    end

    File.read("/tmp/resume.pdf")
  end

  private

  def pdf_list_education(pdf, education)
    pdf.text("Education", :size => 14, :style => :bold)
    pdf.move_down 10
    education.each do |ed, details|
      pdf.text(ed, :style => :bold)
      write_edu(pdf, details, "Start Date")
      write_edu(pdf, details, "End Date")
      write_edu(pdf, details, "Degree")
      write_edu(pdf, details, "GPA")
    end
  end

  def pdf_list_academic_experience(pdf, academic_activities)
    pdf.text("Academic Activities", :style => :bold, :size => 14)
    pdf.move_down 10
    academic_activities.each do |act, details|
      pdf.text(act, :style => :bold)
      details.each do |detail|
        pdf.float { pdf.text "•" }
        pdf.indent(10) do
          pdf.text(detail, :inline_format => true, :leading => 2)
        end
      end
    end
  end

  def pdf_list_experience(pdf, experience)
    pdf.text("Experience", :size => 14, :style => :bold)
    pdf.move_down 10
    experience.each_with_index do |exp, i|
      company_name = exp.first
      details = exp.second
      pdf.float do
        pdf.text(company_name, :size => 14, :style => :bold)
      end
      pdf.float do
        pdf.indent(400) do
          pdf.text("#{details["Start Date"]} - #{details["End Date"]}")
        end
      end
      pdf.move_down 15
      pdf.text(details["Department"])
      pdf.text(details["Position"], :style => :italic)
      pdf.move_down 10
      pdf.text("Responsibilities", :style => :bold)
      details["Responsibilities"].each do |resp|
        pdf.float { pdf.text "•" }
        pdf.indent(10) do
          pdf.text(resp, :inline_format => true, :leading => 2)
        end
      end
      if i == 0 #HACK: This is totally non-deterministic based on the rendered height of the above data
        pdf.start_new_page
        pdf.move_down 5
      else
        pdf.move_down 20
      end
    end
  end

  def pdf_list_technologies(pdf, technologies)
    pdf.text("Technologies", :size => 14, :style => :bold)
    pdf.move_down 10
    technologies.each_slice(3) do |slice|
      slice.each_with_index do |slice, i|
        pdf.float do
          pdf.indent(i * 200) do
            write_tech_bullet(pdf, slice)
          end
        end
      end
      pdf.move_down 20
    end
  end

  def pdf_objective(pdf, objective)
    pdf.text("Objective", :size => 14, :style => :bold)
    pdf.move_down 10
    pdf.text objective
  end

  def pdf_header(pdf, name)
    pdf.text(name, :size => 25, :style => :bold)
    pdf.stroke_horizontal_rule
  end

  def write_edu(pdf, details, edu)
    pdf.float { pdf.text("#{edu}:", :style => :italic) }
    pdf.indent(120) do
      pdf.text(details[edu].to_s, :inline_format => true, :leading => 2)
    end
  end

  def write_tech_bullet(pdf, tech)
    pdf.float { pdf.text "•" }
    pdf.indent(10) do
      pdf.text(tech, :inline_format => true, :leading => 2)
    end
  end
end
