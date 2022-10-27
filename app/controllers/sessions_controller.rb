class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    # https://ruby-doc.org/core-3.1.2/doc/syntax/calling_methods_rdoc.html#label-Safe+Navigation+Operator
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back #{user.username}!"
    else
      redirect_to signin_path, notice: 'Username and/or password mismatch'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
