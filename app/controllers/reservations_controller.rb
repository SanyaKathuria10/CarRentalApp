class ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    reservations = Reservation.all
    render('reservations/index',:locals => {:reservations => reservations})
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    reservation = Reservation.find(params[:id])
    render('show',:locals => {:reservation => reservation})
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    reservation = Reservation.find(params[:id])
    render('edit',:locals => {:reservation => reservation})
  end

  # POST /reservations
  # POST /reservations.json
  def create
      reservation = Reservation.new(reserve_params)
      respond_to do |format|
        if reservation.update(reserve_params)
          format.html { render :show,:locals => {:reservation => reservation}, notice: 'Reservation was successfully created.' }
          format.json { render :show,:locals => {:reservation => reservation}, status: :ok, location: reservation }
        else
          format.html { render :edit,:locals => {:reservation => reservation} }
          format.json { render json: reservation.errors, status: :unprocessable_entity }
        end
      end
    end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    reservation = Reservation.find(params[:id])
    respond_to do |format|
      if reservation.update(car_params)
        format.html { render :show,:locals => {:reservation => reservation}, notice: 'Reservation was successfully created.' }
        format.json { render :show,:locals => {:reservation => reservation}, status: :ok, location: reservation }
      else
        format.html { render :edit,:locals => {:reservation => reservation} }
        format.json { render json: reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    respond_to do |format|
      reservation = Reservation.find(params[:id])
      reservation.destroy
      redirect_to request.referrer
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:checkout_time, :return_time, :total_bill, :reservation_status)
    end

    def reserve_params
     params.permit(:checkout_time, :return_time, :total_bill, :reservation_status, :user_id, :car_id)
    end
end
