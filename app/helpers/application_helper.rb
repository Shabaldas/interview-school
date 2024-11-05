# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice then 'bg-green-500'
    when :alert then 'bg-red-500'
    else 'bg-gray-500'
    end
  end
end
