class EventsController < ApplicationController
  def create
    # TODO create a new event that takes in the
    # params[:event][:title], params[:event][:note],
    # params[:event][:start_time], params[:event][:end_time],
    # user_id: current_user.id, calendar_id: params[:calendar_id]
    #
    # If the event saves respond with the event and
    # a status code of 200
    #
    # Else send a message leveraging the instance_error_message
    # to send the error full message or default message and
    # a status code of 422
  end

  def show
    # TODO find the event from the params[:id]
    #
    # Ensure that the belongs to the calendar
    # from the params[:calendar_id] and the
    # current_user id
    #
    # If the event is not found respond with
    # a message and a status code of 404
    #
    # Respond with this event or nil
  end

  def update
    # TODO find the event from the params[:id]
    #
    # Ensure that the belongs to the calendar
    # from the params[:calendar_id] and the
    # current_user id
    #
    # If the event is not found respond with
    # a message and a status code of not found
    #
    # If the event is found and valid, update
    # it from the params passed in of
    # :title, :note, :start_time, :end_time
    #
    # If that is successful respond with the
    # event and a status code of ok
    #
    # Else send a message leveraging the
    # instance_error_message to send the error
    # full message or default message and
    # a status code of 422
  end

  def delete
    # TODO find the event from the params[:id]
    # Ensure that the belongs to the calendar
    # from the params[:calendar_id] and
    # the current_user id
    #
    # If the event is not found respond with
    # a message and a status code of not found
    #
    # If the event is found and valid, mark it
    # as deleted with the mark_deleted method
    # from the model concern FlagDeleted
    #
    # If that works, respond with a message
    # and a status code of ok
    #
    # If it fails to mark as deleted, respond
    # with a message leveraging the
    # instance_error_message to send the error
    # full message or default message and
    # a status code of 422
  end
end
