# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @enrolled_sections_count = current_student.sections.count
    @available_sections_count = Section.where.not(id: current_student.sections.pluck(:id)).count
  end
end
