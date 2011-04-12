class Page < ActiveRecord::Base
  before_save :downcase_slug 

  validates_presence_of :slug, :title, :body
  validates_uniqueness_of :slug

  def downcase_slug
    self.slug.downcase!
  end

  def name
    self.title
  end
end
