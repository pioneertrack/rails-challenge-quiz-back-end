module Concerns::SaveError
  extend ActiveSupport::Concern

  DEFAULT_MESSAGE = 'There was an issue processing your request'

  def instance_error_message(instance = nil, message = DEFAULT_MESSAGE)
    instance.errors.full_messages.first
  rescue
    message
  end
end
