class Api::V1::DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all.order(created_at: :desc)
    render json: @doctors
  end

  def show
    @doctor = Doctor.find(params[:id])
    if @doctor
      render json: @doctor
    else
      render json: { error: 'Doctor not found' }, status: :not_found
    end
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      render json: {
        status: { code: 200, message: 'Added doctor successfully', data: @doctor }
      }, status: :ok
    else
      render json: {
        status: { code: 400, message: 'Failed to add doctor', errors: @doctor.errors.full_messages }
      }, status: :bad_request
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    if @doctor.destroy
      render json: {
        status: { code: 200, message: 'doctor deleted successfully', data: @doctor }
      }
    else
      render json: {
        status: { code: 400, message: 'Failed to add doctor', errors: @doctor.errors.full_messages }
      }, status: :bad_request
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :image, :specialization, :bio, :fee)
  end
end
