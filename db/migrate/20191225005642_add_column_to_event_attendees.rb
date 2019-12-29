class AddColumnToEventAttendees < ActiveRecord::Migration[6.0]
  def change
    add_column :event_attendees, :is_attending, :boolean, :default => false
  end
end
