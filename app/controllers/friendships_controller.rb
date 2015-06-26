class FriendshipsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:create]
	before_action :set_friendship, only: [:destroy, :accept]

	#should take advantage of user.request_freindships 
	def create
		@friendship  = current_user.request_friendship(@user)
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Created!"}
		end
	end

	def destroy
		@friendship = Friendship.find(params[:id]) if params[:id].present?
		if @friendship then @friendship.destroy
			respond_to do |format|
				format.html {redirect_to users_path, notice: "Friendship Deleted!"}
			end
		end
	end

	def accept
		@friendship.accept_friendship
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.user, recipient: @friendship.friend
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.friend, recipient: @friendship.user		
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Accepted!"}
		end 
	end

private 
	def set_user
  		@user = User.find(params[:user_id]) if params[:user_id].present?
  	end

  	def set_friendship
  		@friendship = Friendship.find(params[:id])
  	end 
end 