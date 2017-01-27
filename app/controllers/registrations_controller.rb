# We are enhiriting here from Devise controller. The purpose of this is to
# override devise methods and permit our custom 'name' attribute. Without this
# forms wouldn't work properly with 'name' fields in them. For all of this to
# work we need this line in routes.rb:
# devise_for :users, :controllers => { registrations: 'registrations' }
class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:email, :name, :password,
                                 :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :password,
                                 :password_confirmation, :current_password)
  end
end
