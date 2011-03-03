class Publication < ActiveRecord::Base
  belongs_to :publisher

  validates_presence_of :title, :author
end
