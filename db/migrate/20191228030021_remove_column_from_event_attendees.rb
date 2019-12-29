class RemoveColumnFromEventAttendees < ActiveRecord::Migration[6.0]
  def change
    remove_column :event_attendees, :is_attending
    add_column :event_attendees, :status, :integer
  end
end
