class Customer < ActiveRecord::Base
  after_initialize :normalize
  before_validation :normalize
  belongs_to :user
  # attr_accessor :pdf_forms_attributes
  has_many :pdf_forms, dependent: :destroy, :class_name => "PdfForm::Form"
  accepts_nested_attributes_for :pdf_forms
  default_scope -> { order(name: :asc) }
  validates :user_id, presence: true
  validate :any_present?
  validates :name, length: { maximum: 50 }
  VALID_NUMBER_REGEX = /\A^[0-9]{1,10}$\z/
  validates :phone, length: { is: 10 }, format: { with: VALID_NUMBER_REGEX }
  validates :license_plate, length: { maximum: 20 }

  # Normalize query fields to quirky short hand rules
  def normalize
  	if !self.phone.nil?
	  	self.phone = self.phone.gsub(/[^a-z0-9]/i, '')
	  	if self.phone.length == 8
	  		area_code = ""
	  		first = self.phone[0]
	  		if first == "6"
	  			area_code = "619"
	  		elsif first == "8"
	  			area_code = "858"
	  		end
	  		self.phone = area_code + self.phone[1..-1]
	 	  elsif self.phone.length == 10
	 		  # do nothing for now
	 	  else
	 		  # do nothing for now
	 	  end
	  end
  end


  # Check if any forms are present
  def any_present?
    if name.blank? and phone.blank? and license_plate.blank?
      errors.add :base, "You must fill in at least one field"
    end
  end  

end
