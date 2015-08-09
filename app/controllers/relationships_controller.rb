class RelationshipsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  # POST /relaionships
  # フォロー
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  # DELETE /relationships/1
  # フォロー解除
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end