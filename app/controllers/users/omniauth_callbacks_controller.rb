class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def ecourts
    # You need to implement the method below in your model
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "eCourts", :name => @user.name_full
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.ecourts_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def developer
    stub_hash                  = request.env["omniauth.auth"]
    stub_hash.extra[:fullName] = stub_hash.uid
    stub_hash.extra[:mail]     = stub_hash.info.email
    stub_hash.uid              = 100

    @user = User.find_or_create_from_auth_hash(stub_hash, current_user)

    if @user.persisted?
      flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "developer", :name => @user.name_full
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.developer_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = "There was an error logging you in. Please try again or contact support"
    redirect_to root_path
  end

  def passthru
    raise ActionController::RoutingError.new('Not Found')
  end

  # Bug fix :/
  def new_session_path *args
    new_user_session_path *args
  end
end
