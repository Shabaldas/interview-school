# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  skip_before_action :authenticate_student!

  def new
    @student = Student.new
  end

  def create
    student = Student.find_or_initialize_by(email: student_params[:email])

    if student.valid?
      student.save if student.new_record?
      session[:student_id] = student.id
      flash[:notice] = { text: "Welcome, #{student.first_name}" }
    else
      flash[:alert] = { text: 'Invalid email' }
    end

    redirect_to root_path
  end

  private

  def student_params
    params.require(:student).permit(:email)
  end

  def redirect_if_logged_in
    return unless current_student

    redirect_to root_path
  end
end
