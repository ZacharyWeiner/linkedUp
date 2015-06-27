class ActivitiesController < ApplicationController
	before_action :authenticate_user!, only: [:index]

	def index
		@users = current_user.active_friends
		@users << current_user

		case params[:content] when 'posts'
			@activities = PublicActivity::Activity.where(owner_id: @users, trackable_type: "Post").order("created_at desc")
		else
			@activities = PublicActivity::Activity.where(owner_id: @users).order("created_at desc")
		end 
	end

  	def body_html
  		auto_html(self[:body_html]) { simple_format; link(:target => 'blank') }
  	end
end 