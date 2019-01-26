class Event < ApplicationRecord
  belongs_to :user

  validates :title, :start_time, :end_time, presence: true
  validate :validate_start_before_end

  # TODO see method at the bottom of this page
  validate :validate_calendar_owner, on: :create

  default_scope { where(deleted: false) }

  private

  def validate_start_before_end
    # TODO if the start_time is before the
    # end_time add an error
  end

  def validate_calendar_owner
    # TODO validate that the user_id passed in
    # is the owner of the calendar_id passed in
    #
    # If it is NOT add an error
  end
end
