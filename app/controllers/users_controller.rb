class UsersController < ApplicationController
  def create
    # TODO create and save a new user
    #
    # Name, email, password and
    # password_confirmation are the fields
    # that will be sent in the request
    # body and available as params
    #
    # On success respond with the user
    # and a JWT token that the UI can
    # use to do further actions with a
    # status code of 200
    #
    # On fail respond with a message
    # with a message leveraging the
    # instance_error_message to send the error
    # full message or default message and
    # a status code of unprocessable entity status
  end

  def show
    # TODO respond with the current user
  end

  def update
    # TODO update the current user's name
    # and/or email
    #
    # If it fails to mark as update, respond
    # with a message leveraging the
    # instance_error_message to send the error
    # full message or default message and
    # a status code of 422
  end
end
