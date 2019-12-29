module EventsHelper
  def count_event(event)
    if event.zero?
      'You have no created event!'
    elsif event == 1
      'Your event'
    else
      'Your events'
    end
  end

  def event_creator?
    event = Event.find(params[:id])
    event.creator == current_user
  end

  def show_creator_name
    event = Event.find(params[:id])
    if event.creator == current_user
      'created by you'.upcase
    else
      "created by #{event.creator.name}".upcase
    end
  end

  def invited_guest(event)
    invited_guest = ''
    event.event_attendees.each do |invited|
      if invited.attendee == current_user && invited.attending?
        invited_guest = '<span class="badge badge-secondary">Accepted Invitation</span>'
      elsif invited.attendee == current_user && invited.unset?
        invited_guest = "<a href='/invites/#{invited.id}'><span class='badge badge-danger'>Yet to accept invitation</span></a>"
      end
    end
    invited_guest
  end

  def creator_is_current_user(event)
    event.creator == current_user
  end

  def invitee_is_current_user(event)
    event.event_attendees.each do |invited|
      return true if invited.attendee == current_user && invited.attending?
    end
    return false
  end
end
