# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_student!

  helper_method :current_student
  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end

  def authenticate_student!
    return if current_student

    redirect_to new_session_path
  end
end
