class CreateEvents < ActiveRecord::Migration[5.2]
  class << self
    def up
      create_table :events do |t|
        t.references :user, foreign_key: true, index: true
        t.references :calendar, foreign_key: true, index: true
        t.string :title
        t.text :note
        t.datetime :start_time
        t.datetime :end_time
        t.boolean :deleted, default: false
        t.datetime :deleted_at

        t.timestamps
      end

      add_index :events, :title
    end

    def down
      drop_table :events
    end
  end
end
