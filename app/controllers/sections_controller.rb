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
    current_student.sections << @section unless current_student.sections.include?(@section)
    redirect_to sections_path, notice: "Enrolled in #{@section.subject.name}"
  end

  def withdraw
    current_student.sections.delete(@section)
    redirect_to sections_path, notice: "Withdrawn from #{@section.subject.name}"
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end
end
