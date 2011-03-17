class Press < ActiveRecord::Base
  before_save :validates_duplication

  def validates_duplication
    valid = false
    presses = Press.where(:name => self.name) 
    if presses.count > 0
      presses.each do |p|
        if (p.address == self.address &&
             p.telephone == self.telephone &&
             p.fax == self.fax &&
             p.email == self.email &&
             p.website == self.website)
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
