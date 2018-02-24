class RegistrationsController < Devise::RegistrationsController
    private
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :contact, :user_type, :currently_reserved)
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :password, :contact, :user_type,  :currently_reserved)
    end
  end
