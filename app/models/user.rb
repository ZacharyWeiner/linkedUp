class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates_presence_of :username
         validates_uniqueness_of :username

    has_many :friendships, dependent: :destroy

    #needs to be able to find all people that requested to be our friend 
    has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
end
