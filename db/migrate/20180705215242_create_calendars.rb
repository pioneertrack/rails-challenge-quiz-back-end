class CreateCalendars < ActiveRecord::Migration[5.2]
  class << self
    def up
      create_table :calendars do |t|
        t.references :user, foreign_key: true
        t.string :title
        t.boolean :deleted, default: false
        t.datetime :deleted_at

        t.timestamps
      end
    end

    def down
      drop_table :calendars
    end
  end
end
