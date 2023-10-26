class Api::V1::ReservationsController < ApplicationController
  # GET /api/v1/users/:user_id/reservations
  def index
    reservations = current_user.reservations
    render json: reservations
  end

  # POST /api/v1/users/:user_id/reservations
  # Create action: handles the creation of a new reservation for the current user.
  def create
    # Check if a reservation with the provided parameters already exists for the current user
    existing_reservation = current_user.reservations.find_by(reservation_params)

    if existing_reservation
      # If an existing reservation is found, return an error response
      render json: { status: 'error', message: 'Reservation already exists' }, status: :unprocessable_entity
    else
      # If no existing reservation is found, create a new reservation for the current user
      @reservation = current_user.reservations.new(reservation_params)

      if @reservation.save
        # If the reservation is successfully saved, return a success response
        render json: { status: 'Success', message: 'Reservation created successfully' }, status: :created
      else
        # If there are errors preventing the reservation from being saved, return an error response
        render json: { status: 'error', message: @reservation.errors.full_messages.to_sentence,
                       errors: @reservation.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end

  # GET /api/v1/users/:user_id/reservations/:id
  def show
    reservation = current_user.reservations.find(params[:id])
    render json: reservation
  end

  # PUT/PATCH /api/v1/users/:user_id/reservations/:id
  # Update action: handles updating an existing reservation for the current user
  def update
    # Attempt to find the reservation by ID for the current user
    @reservation = current_user.reservations.find(params[:id])

    # Check if the reservation can be updated with the provided parameters
    if @reservation.update(reservation_params)
      # If successful, render the updated reservation as JSON response
      render json: @reservation
    else
      # If there are validation errors preventing the update, render the errors as JSON response
      # with unprocessable entity status
      render json: @reservation.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    # If the reservation with the given ID is not found, render a JSON response
    # with a not found status and error message
    render json: {
      error: 'Reservation not found.'
    }, status: :not_found
  end

  # DELETE /api/v1/users/:user_id/reservations/:id
  def destroy
    @reservation = current_user.reservations.find_by(id: params[:id])

    if @reservation
      if @reservation.destroy
        render json: { message: 'Reservation deleted successfully.' }
      else
        render json: { error: 'Unable to delete reservation.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Reservation not found.' }, status: :not_found
    end
  end

  private

  # Whitelist parameters for reservation creation and update
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :room_id)
  end
end
