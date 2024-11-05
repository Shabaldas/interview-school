# frozen_string_literal: true

class SectionsController < ApplicationController
  before_action :set_section, only: [:enroll, :withdraw]

  def index
    @sections = current_student.sections.includes(:subject, :teacher, :classroom)
  end

  def available
    @available_sections = Section.where.not(id: current_student.sections.pluck(:id))
                            .includes(:subject, :teacher, :classroom)
  end

  def enroll
    enrollment = current_student.enrollments.build(section: @section)

    if enrollment.save
      redirect_to available_sections_path, notice: { text: "Enrolled in #{@section.subject.name}" }
    else
      redirect_to available_sections_path, alert: { text: enrollment.errors.full_messages.to_sentence }
    end
  end

  def withdraw
    current_student.sections.delete(@section)

    redirect_to sections_path, alert: { text: "Withdrawn from #{@section.subject.name}" }
  end

  def download_schedule_pdf
    pdf = ::StudentSchedulePdfService.new(current_student).generate
    send_data pdf.render,
              filename: "#{current_student.full_name}_schedule.pdf",
              type: 'application/pdf',
              disposition: 'inline'
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end
end
