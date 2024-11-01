# frozen_string_literal: true

# rubocop:disable Rails/I18nLocaleTexts

class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show; end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit; end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params.merge(teacher_subjects_params))

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Class was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params.merge(teacher_subjects_params))
        format.html { redirect_to @subject, notice: 'Class was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subject
    @subject = Subject.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
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

# rubocop:enable Rails/I18nLocaleTexts
