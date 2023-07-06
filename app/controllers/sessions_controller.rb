class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      render json: { user: user, success: "Welcome back, #{user.firstname}" }
    else
      render json: { error: "User not found" }
    end
  end

  def destroy
    render json: { user: nil, success: "Logged out" }
  end
end
