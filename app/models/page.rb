class Page < ActiveRecord::Base
  validates_presence_of :slug, :title, :body
  validates_uniqueness_of :slug
end
