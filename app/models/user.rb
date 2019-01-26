class User < ApplicationRecord
  has_secure_password

  has_many :calendars
  has_many :events

  # TODO validate the presence of name and email
  ################################################
  # TODO validate the format of the email with
  # this regex
  #
  # /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #
  # and ensure it is unique and not case sensitive
  ################################################
  # TODO validate that there are at least
  # two words in the name column

  before_validation :format_email
  after_create :create_calendar

  def access_token(user_agent)
    # TODO flesh out the JsonWebToken encode
    # method in the lib/util/json_web_token.rb
    # file
    Util::JsonWebToken.encode(self, user_agent)
  end

  class << self
    def authenticate(email, password)
      # TODO authenticate the user via the email
      # and password passed in
      #
      # If the user exists and the password is
      # valid respond with the user
      #
      # Else respond with nil
    end
  end

  private

  def create_calendar
    Calendar.create!(title: name, user_id: id)
  end

  def format_email
    self.email = email.downcase
  end
end
