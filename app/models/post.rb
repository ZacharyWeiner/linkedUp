class Post < ActiveRecord::Base
	include PublicActivity::Model

	belongs_to :user 
	validates_presence_of :user_id 
	validates_presence_of :user_id 

  auto_html_for :content do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => true)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
