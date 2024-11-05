# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_student
  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end
end
