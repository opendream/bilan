class Distributor < ActiveRecord::Base
  before_save :validates_duplication

  def validates_duplication
    valid = false
    distributors = Distributor.where(:name => self.name) 
    if distributors.count > 0
      distributors.each do |d|
        if (d.address == self.address &&
             d.telephone == self.telephone &&
             d.fax == self.fax &&
             d.email == self.email &&
             d.website == self.website)
          valid = false
          break
        else
          valid = true
        end
      end
    else
      valid = true
    end
    valid
  end
end
