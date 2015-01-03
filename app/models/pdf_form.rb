class PdfForm < ActiveRecord::Base
  # attr_accessor :content
  # serialize :content, JSON #not working for some fucking reason
  # attr_accessor :repair_hash
  belongs_to :customer, :class_name => "Customer", :foreign_key => 'Customer_id'
  validate :repair_count_within_limit, :on => :create
  has_many :repairs, dependent: :destroy  
  accepts_nested_attributes_for :repairs, :reject_if => lambda { |a| a[:instructions].blank? }, :allow_destroy => true
  default_scope -> { order(created_at: :desc) }
  # validates :customer_id, presence: true 
  validates :content, presence: true
  validate :check_fields

  def check_fields
    h = eval(self.content)
    
    if h.nil?
      errors.add(:base, "Content be present")
      return
    end

    if !h.key?("odo") or h["odo"].nil?
      errors.add(:base, "Odo field must be present")
      return
    end  

    if !h.key?("estimate") or h["estimate"].nil?
      errors.add(:base, "Estimate field must be present")
      return
    end  

    if !h.key?("invoice_no") or h["invoice_no"].nil?
      errors.add(:base, "Invoice field must be present")
      return
    end
  end

  def repair_count_within_limit
    if self.repairs.size >= 12
      errors.add(:base, "Exceeded repair limit")
    end
  end 

end
