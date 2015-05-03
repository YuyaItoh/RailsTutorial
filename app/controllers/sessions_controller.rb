class SessionsController < ApplicationController
  def new
  end

  def create
    user =  User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user # defined in sessions_helper
      redirect_to user #redirect_to user_path(user)と同じ
    else
      # エラーメッセージを表示する
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
