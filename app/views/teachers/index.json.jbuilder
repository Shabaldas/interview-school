# frozen_string_literal: true

json.array! @teachers, partial: 'teachers/teacher', as: :teacher
