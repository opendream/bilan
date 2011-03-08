class Publication < ActiveRecord::Base
  belongs_to :publisher

  validates_presence_of :title, :author

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
end
