# frozen_string_literal: true

module Nameable
  extend ActiveSupport::Concern

  def full_name
    "#{first_name} #{last_name}"
  end
end
