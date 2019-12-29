class InvitesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_event_invitee, only: [:show, :update]
  before_action :correct_event_creator, only: [:new, :create]

  def index
    @all_invites = EventAttendee.where('attendee_id = ? AND status != ?', current_user, 1)
    @invitation = EventAttendee.new
  end

  def new
    @invite = Event.find(params[:id])
    @invitation = EventAttendee.new
  end

  def create
    @invite = Event.find(params[:id])

    @invitation = @invite.event_attendees.build(attendee_id: invitation_params)
    if @invitation.save
      flash.now['alert-success'] = 'Invitation has been sent successfully!'
      render :new
    else
      flash.now['alert-danger'] = 'You have to select a Attendee'
      render :new
    end

    respond_to do |format|
      format.html { @invitation }
    end
  end

  def show
    @accept_invite = EventAttendee.find(params[:id])
    @invited = EventAttendee.where('id = ? AND attendee_id = ? ', @accept_invite, current_user).take
  end

  # def edit
  #   @accept_invite = EventAttendee.find(params[:id])
  #   @invited = EventAttendee.where('id = ? AND attendee_id = ? ', @accept_invite, current_user).take
  # end

  def update
    @accept_invite = EventAttendee.find(params[:id])
    if params[:decline_button]
      update_not_attending = @accept_invite.update_attributes(status: 'declined')
      if update_not_attending
        flash['alert-warning'] = 'You have declined the invite!'
      end
    elsif params[:accept_button]
      update_is_attending = @accept_invite.update_attributes(status: 'attending')
      if update_is_attending
        flash['alert-success'] = 'You are going to the event!'
      end
    end
    redirect_to invites_path
  end

  def destroy
    @delete_invite = EventAttendee.find(params[:id])
    @delete_invite.destroy
    flash['alert-warning'] = 'You have declined the invite!'
    redirect_to invites_path
  end

  private

  def invitation_params
    params[:event_attendee][:attendee_id]
  end

  def correct_event_invitee
    @accept_invite = EventAttendee.find_by(id: params[:id])
    if @accept_invite.nil? || @accept_invite.attendee != current_user
      redirect_to dashboard_path
    end
  end

  def correct_event_creator
    @invite = Event.find_by(id: params[:id])
    if @invite.nil? || @invite.creator != current_user
      redirect_to dashboard_path
    end
  end

end
