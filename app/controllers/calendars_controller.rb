class CalendarsController < ApplicationController
  def create
    calendar = Calendar.new(create_params)

    if calendar.save
      render json: { calendar: calendar }, status: :ok
    else
      render json: {
        message: instance_error_message(
          calendar,
          'We were unable to save your calendar'
        )
      }, status: :unprocessable_entity
    end
  end

  def show
    # TODO get the calendar from the params[:id]
    #
    # Ensure that the calendar belongs to the
    # current user
    #
    # If it does not respond with a message and
    # a status code of not found
    #
    # Otherwise respond with the calendar and a
    # status code of ok
  end

  def show_user_calendars
    render json: { calendars: current_user.calendars }, status: :ok
  end

  def month_events
    # TODO get the calendar's months events. You have
    # the params calendar's is (params[:id]) and the
    # date (params[:date]) from which to extract the
    # months events
    #
    # I.E. events = calendar.get_month_events(date)
    #
    # Be sure that the calendar is owned by the
    # current user
    #
    # If it is respond with the events: events with
    # a status code of 200
    #
    # If you cannot find a calendar that is owned by
    # the current user from the params[:id] respond
    # with a message and a status code of 404
    #
    # If the params[:date] is not a valid date
    # respond with a message and a status code of 422
  end

  private

  def create_params
    params.require(:calendar).permit(
      :title
    ).merge(
      user_id: current_user.id
    )
  end
end
