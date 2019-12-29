class EventAttendee < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'

  default_scope -> { order(updated_at: :desc) }

  validates :attendee_id, presence: true
  validates_uniqueness_of :attendee_id,
    scope: 'attended_event_id',
    message: 'is already going to the event'

  enum status: [:attending, :declined, :unset]
end
