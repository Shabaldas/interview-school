# frozen_string_literal: true

json.extract! subject, :id, :name, :description, :created_at, :updated_at
json.url subject_url(subject, format: :json)
