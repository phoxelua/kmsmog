class Repair < ActiveRecord::Base
  belongs_to :pdf_form
  before_validation :normalize

  def normalize
  	puts "REPAIR NORMALIZZE >>>"
  	p self
  end

end
