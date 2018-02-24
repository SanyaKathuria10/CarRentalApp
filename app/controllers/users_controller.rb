class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[ :login]
  protect_from_forgery prepend: true
  # GET /users
  # GET /users.json

  def index
    @users=User.all
  end

  def book_car
    render('users/bookCar',:locals => {:user => params[:id]})
  end

  def checkout
    reservation = Reservation.find(params[:id])
    if(Time.now.to_datetime > reservation.checkout_time && reservation.reservation_status =='Reserved')
      reservation.check_out
    end
    redirect_to request.referrer
  end

  def return_car
    reservation = Reservation.find(params[:id])
    if reservation.reservation_status == 'Checked_out'
      reservation.return
    end
    redirect_to request.referrer
  end

  def cancel_reservation
    reservation = Reservation.find(params[:id])
    unless reservation.reservation_status == 'Checked_out'
      reservation.cancel
    end
    redirect_to request.referrer
  end

  def current_reservations
    reservation = Reservation.get_currentReservationForUser(params[:id])
    if(!reservation.empty?)
      render('users/reservations', :locals => {:reservation => reservation.first})
    else
      render('users/noReservation')
    end
  end

  def checkout_history
    reservatn = Reservation.get_userhistory(params[:id]).reverse
    if(!reservatn.empty?)
      render('users/checkoutHistory', :locals => {:reservations => reservatn})
    else
      render('users/noReservation')
    end
  end

  def list_users
    @users = User.where(user_type: 'user')
    render('users/admin')
  end

  def list_admins
    @users = User.where("user_type = 'admin' OR user_type = 'superadmin'")
    render('users/admin')

  end

  def login
    render('users/login')
  end

  def login_verify
      check_login = false
      password = params['password']
      user = User.find_by_email(params['email'])
      if(user.present?)
        (user.password==password)?check_login=true:check_login=false
          if(check_login)
             redirect_to(:action=>'logged_in', id: user.id)
          end
      else
        render('users/login')
      end
  end

  def logged_in
    if (current_user.user_type=='user')
      render('users/index')
    elsif(current_user.user_type=='admin')
      render('users/adminIndex')
    elsif(current_user.user_type=='superadmin')
      render('users/superAdminIndex')
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    user = User.find(params[:id])
    render('show',:locals => {:user => user})
  end

  # GET /users/new
  def new
    render('login')
  end

  # GET /users/1/edit
  def edit
    user = User.find(params[:id])
    render('edit',:locals => {:user => user})
  end

  def update_profile
    user= User.find(params[:id])
    render('updateprofile',:locals => {:user => user})
  end

  # POST /users
  # POST /users.json
  def create
    parameter = admin_params
    parameter.merge!(:currently_reserved=>false)
    user = User.new(parameter)
    respond_to do |format|
      if user.save
        format.html { render :show,:locals => {:user => user}, notice: 'User was successfully created.' }
        format.json { render :show,:locals => {:user => user}, status: :created, location: user }
      else
        format.html { render :new }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create_admin
    parameter = admin_params
    parameter.merge!(:currently_reserved=>false)
    checkEmail = (User.find_by_email(params[:email])).nil?
    paramformat = false

    if (parameter[:email]=~/\A[^@\s]+@[^@\s]+\z/ && parameter[:contact]=~/\A[0-9]{10}\Z/ && parameter[:name]=~/\A[a-zA-Z0-9_]+\Z/)
      paramformat=true
    end

    if(!checkEmail or !paramformat or (parameter[:password].size<6) )
      render('users/adminError')
    else
      user = User.new(parameter)
      respond_to do |format|
        if user.save
          format.html { render :show,:locals => {:user => user}, notice: 'User was successfully created.' }
          format.json { render :show,:locals => {:user => user}, status: :created, location: user }
        else
          format.html { render :new }
          format.json { render json: user.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user = User.find(params[:id])
    respond_to do |format|
      if user.update(user_params)
        format.html { render :show,:locals => {:user => user}, notice: 'User was successfully updated.' }
        format.json { render :show,:locals => {:user => user}, status: :ok, location: user }
      else
        format.html { render :edit,:locals => {:user => user} }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if User.get_currentlyReservedUsersId(params[:id])
      render('users/error')
    else
      user = User.find(params[:id])
      user.destroy
      redirect_to request.referrer
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit('id', 'name', 'email', 'password', 'contact', 'user_type')
    end

    def admin_params
      params.permit('id', 'name', 'email', 'password', 'contact', 'user_type')
    end
end
