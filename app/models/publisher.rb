class Publisher < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_and_belongs_to_many :collaborators, :class_name => 'User'

  validates_presence_of :name
end
