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

  def get_type_name(t)
    #get_types
  end
end
