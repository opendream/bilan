class Publication < ActiveRecord::Base
  belongs_to :publisher

  validates_presence_of :title, :author

  attr_accessor :isbn

  # Filters -------------------------------------------------------------------

  def before_update
    if self.isbn.size == 13
      self.isbn13 = self.isbn
      self.isbn10 = nil
    elsif self.isbn.size == 10
      self.isbn10 = self.isbn
      self.isbn13 = nil
    end
  end

  # Instance methods ----------------------------------------------------------

  def get_types
    [
      [_('Book'), 1],
      [_('CD-ROM'), 2],
      [_('Software'), 3],
      [_('Map'), 4],
      [_('Other'), 9]
    ]
  end

  def get_publication_type_name
    types = {}
    get_types.each { |i| types.update({i[1] => i[0]}) }
    types.fetch(self.publication_type)
  end

  def name
    return self.title
  end

  def get_isbn
    if !self.isbn13.nil? && !self.isbn13.blank?
      self.isbn13
    elsif !self.isbn10.nil? && !self.isbn10.blank?
      self.isbn10
    else
      ''
    end
  end
end
