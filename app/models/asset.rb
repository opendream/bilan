class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attached_file :attachment,
    :styles => { :medium => '200x200>', :small => '100x100>', :thumb => '50x50#' }
end
