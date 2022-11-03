class ApplicationController < ActionController::Base
  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user
  helper_method :is_admin

  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end

  def ensure_that_is_admin
    redirect_to root_path, notice: 'delete is allowed only for an admin' if current_user && !current_user.admin
  end

  def expire_brewerylist_fragment_cache
    expire_fragment('brewerylist')
  end
end
