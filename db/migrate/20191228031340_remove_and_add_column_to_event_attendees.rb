class RemoveAndAddColumnToEventAttendees < ActiveRecord::Migration[6.0]
  def change
    remove_column :event_attendees, :status, :integer
    add_column :event_attendees, :status, :integer, default: 2
  end
end
