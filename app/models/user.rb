class User < ActiveRecord::Base
  has_many :own_publishers, :class_name => 'Publisher', :foreign_key => 'owner_id'
  has_and_belongs_to_many :publishers
  has_and_belongs_to_many :roles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def publisher_ids
    ids = []
    self.own_publishers.each { |p| ids.push(p.id) }
    ids
  end

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end
end
