class StudentSchedulePdfService
  def initialize(student)
    @student = student
  end

  def generate
    pdf = Prawn::Document.new

    pdf.font 'Helvetica'

    add_header(pdf)
    add_table_body(pdf)
    add_footer(pdf)

    pdf
  end

  private

  attr_reader :student

  def add_header(pdf)
    pdf.text "Schedule for #{student.full_name}", size: 28, style: :bold, align: :center
    pdf.move_down 20
  end

  def add_table_body(pdf)
    table_data = [['Subject', 'Teacher', 'Classroom', 'Days', 'Time']]

    student.sections.each do |section|
      table_data << [
        section.subject.name,
        section.teacher.full_name,
        section.classroom.name,
        section.days_of_week_list,
        "#{section.start_time.strftime('%I:%M %p')} - #{section.end_time.strftime('%I:%M %p')}"
      ]
    end

    column_widths = {
      0 => pdf.bounds.width * 0.25,
      1 => pdf.bounds.width * 0.20,
      2 => pdf.bounds.width * 0.15,
      3 => pdf.bounds.width * 0.25,
      4 => pdf.bounds.width * 0.15
    }

    pdf.table(table_data, header: true, row_colors: ['F0F0F0', 'FFFFFF'], column_widths: column_widths, width: pdf.bounds.width) do
      row(0).font_style = :bold
      row(0).background_color = '4287f5'
      row(0).text_color = 'FFFFFF'
      cells.padding = 8
      cells.borders = [:top, :bottom]
      cells.border_width = 1
      cells.border_color = 'DDDDDD'
      cells.size = 10
      cells.inline_format = true
      column(0..4).align = :center

      cells.each do |cell|
        cell.overflow = :shrink_to_fit
        cell.min_font_size = 8
      end
    end
  end

  def add_footer(pdf)
    pdf.move_down 30
    pdf.text "Generated on #{Time.now.strftime('%A, %d %B %Y at %I:%M %p')}", size: 10, align: :right, style: :italic
  end
end
