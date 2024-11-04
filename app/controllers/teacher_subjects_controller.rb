# frozen_string_literal: true

class TeacherSubjectsController < ApplicationController
  before_action :_set_teacher_subject, only: [:show, :edit, :update, :destroy]
  before_action :_set_teacher, only: [:new, :create]

  def show; end

  def new
    @teacher_subject = TeacherSubject.new level: TeacherSubject::DEFAULT_LEVEL
  end

  def edit; end

  def create
    @teacher_subject = TeacherSubject.new _teacher_subject_params
    @teacher_subject.teacher = @teacher
    if @teacher_subject.save
      flash[:notice] = t('controllers.teacher_subject.create.success')
    else
      render :new
    end
  end

  def update
    if @teacher_subject.update(_teacher_subject_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    @teacher_subject.destroy!
    flash.now[:notice] = t('controllers.teacher_subject.destroy.success')
  end

  private

  def _set_teacher_subject
    @teacher_subject = TeacherSubject.find params[:id]
  end

  def _set_teacher
    @teacher = Teacher.find params[:teacher_id]
  end

  def _teacher_subject_params
    params.require(:teacher_subject).permit(:level, :subject_id)
  end
end
