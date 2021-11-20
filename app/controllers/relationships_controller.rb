class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    
    user = User.find(params[:user_id])
    follower = current_user.relationships.new(followed_id: user.id)
    follower.save
    session[:previous_url] = request.referer 
    redirect_to session[:previous_url]
    
    
    
  end

  def destroy
    user = User.find(params[:user_id])
    follower = current_user.relationships.find_by(followed_id: user.id)
    follower.destroy
    session[:previous_url] = request.referer 
    redirect_to session[:previous_url]
    
  end
end
