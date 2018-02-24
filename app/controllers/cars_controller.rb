class CarsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    cars = Car.all
    render('cars/index',:locals => {:cars => cars})
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    car = Car.find(params[:id])
    render('show',:locals => {:car => car})
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
    car = Car.find(params[:id])
    render('edit',:locals => {:car => car})
  end

  # POST /cars
  # POST /cars.json
  def create
    parameters = add_car_params
    uniqueCar = Car.find_by_lisence(parameters[:lisence]).nil?
    if(!uniqueCar or parameters[:lisence].size!=7 or parameters[:style].nil?)
      render('cars/carError')
    else
      car = Car.new(parameters)
      respond_to do |format|
        if car.save
          format.html { render :show,:locals => {:car => car}, notice: 'Car was successfully created.' }
          format.json { render :show,:locals => {:car => car}, status: :created, location: car }
        else
          format.html { render :new }
          format.json { render json: car.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    car = Car.find(params[:id])
    parameters = car_params
    if(parameters[:lisence].size!=7)
      render('cars/carError')
    else
      respond_to do |format|
        if car.update(parameters)
          format.html { render :show,:locals => {:car => car}, notice: 'Car was successfully updated.' }
          format.json { render :show,:locals => {:car => car}, status: :ok, location: car }
        else
          format.html { render :edit,:locals => {:car => car} }
          format.json { render json: car.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    if Car.getcurrentlyReservedCarsId.include?params[:id]
      render('users/error')
    else
      car = Car.find(params[:id])
      car.destroy
      redirect_to request.referrer
    end
  end

  def get_availableCars
    checkout_time = params[:checkout_time]
    return_time = params[:return_time]
    userID = params[:bookUserId]

    dayInAdvance = ((checkout_time.to_datetime - Time.now.to_datetime)*24*60*60).to_f/1.days
    duration = ((return_time.to_datetime - checkout_time.to_datetime)*24*60*60).to_f/1.hours

    if(return_time.to_datetime < checkout_time.to_datetime or dayInAdvance > 7 or duration < 1 or duration > 10 or User.get_currentlyReservedUsersId(userID))
      render('cars/error')
    else
      parameters = available_car_params
      temp = parameters
      temp.delete_if{|k,v| v=='' or k =='bookUserId' or k == 'checkout_time' or k == 'return_time'}
      symbolizedParams = temp.to_hash
      symbolizedParams.symbolize_keys!
      cars = Car.get_availableCars checkout_time, return_time , symbolizedParams
      render('cars/availableCarsIndex',:locals => {:cars => cars, :checkout_time => checkout_time, :return_time => return_time, :user_id => userID})
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:manufacturer, :model, :lisence, :hourly_rate, :location, :style).transform_values! {|v| v.upcase}
    end

    def add_car_params
      params.permit(:manufacturer, :model, :lisence, :hourly_rate, :location, :style).transform_values! {|v| v.upcase}
    end

    def available_car_params
      params.permit(:manufacturer, :model, :lisence, :hourly_rate, :location, :style, :bookUserId).transform_values! {|v| v.upcase}
    end
end
