module FlagDeleted
  extend ActiveSupport::Concern

  def mark_deleted
    mark.save
  end

  def mark_deleted!
    mark.save!
  end

  def unmark_deleted
    unmark.save
  end

  def unmark_deleted!
    unmark.save!
  end

  private

  def mark
    self.deleted = true
    self.deleted_at = DateTime.now

    self
  end

  def unmark
    self.deleted = false
    self.deleted_at = nil

    self
  end
end
