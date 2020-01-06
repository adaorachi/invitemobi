module EventAttendeesHelper

  def user_invited_events
    invitation = []
    invited_user = EventAttendee.includes(:attended_event).all.where('attendee_id = ? AND status = ?', current_user, 2)
    invited_user.each do |invite|
      invitation.push({'id' => invite.id, 'name' => invite.attended_event.creator.name, 'title' => invite.attended_event.title})
    end
    invitation
  end

  def string_length(string, length)
    string.length > length ? "#{string[0..length]}..." : string
  end
end