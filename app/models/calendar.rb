class Calendar < ApplicationRecord
  include FlagDeleted

  belongs_to :user

  validates :title, presence: true

  default_scope { where(deleted: false) }

  def get_month_events(date)
    # TODO search and return events from the
    # database in which the start_time column
    # occurs within the same year and month as
    # the date passed in
  end
end
