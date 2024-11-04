# frozen_string_literal: true

class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @subjects = Subject.all
  end

  def show; end

  def new
    @subject = Subject.new
  end

  def edit; end

  def create
    @subject = Subject.new(subject_params.merge(teacher_subjects_params))

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: t('controllers.subject.create.success') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @subject.update(subject_params.merge(teacher_subjects_params))
        format.html { redirect_to @subject, notice: t('controllers.subject.update.success') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: t('controllers.subject.destroy.success') }
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :description)
  end

  def teacher_subjects_params
    return {} if params[:subject][:teacher_ids].nil?

    @subject.teacher_subjects.each(&:mark_for_destruction) if @subject.present?
    {
      teacher_subjects_attributes: params[:subject][:teacher_ids].reject(&:empty?).map { |id| { teacher_id: id } }
    }
  end
end
