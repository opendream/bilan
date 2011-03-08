class User < ActiveRecord::Base
  has_many :own_publishers, :class_name => 'Publisher', :foreign_key => 'owner_id'
  has_and_belongs_to_many :publishers

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
