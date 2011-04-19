class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attached_file :attachment,
    :styles => { :medium => '240>x240>', :small => '120x120>', :thumb => '50x50#' }
end
