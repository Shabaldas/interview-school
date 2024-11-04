# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  def index
    @teachers = Teacher.all
  end

  def show; end

  def new
    @teacher = Teacher.new
  end

  def edit; end

  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: t('controllers.teacher.create.success') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: t('controllers.teacher.update.success') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: t('controllers.teacher.destroy.success') }
    end
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name)
  end
end
