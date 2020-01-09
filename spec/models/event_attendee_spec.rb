# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventAttendee, type: :model do
  context 'validations' do
    it { should validate_presence_of(:attendee_id) }
    # subject { EventAttendee.create(attended_event_id: 1, attendee_id: 2, status: 'unset') }
    # it { should validate_uniqueness_of(:attendee_id).scoped_to(:attended_event_id) }
  end

  context 'Associations' do
    it { should belong_to(:attendee).class_name('User') }
    it { should belong_to(:attended_event).class_name('Event') }
  end
end