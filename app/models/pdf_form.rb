class PdfForm < ActiveRecord::Base
  # attr_accessor :content
  # serialize :content, JSON #not working for some fucking reason
  # attr_accessor :repair_hash
  belongs_to :customer, :class_name => "Customer", :foreign_key => 'Customer_id'
  before_validation :flush_to_content
  has_many :repairs, dependent: :destroy  
  accepts_nested_attributes_for :repairs, :reject_if => lambda { |a| a[:instructions].blank? }, :allow_destroy => true
  default_scope -> { order(created_at: :desc) }
  # validates :customer_id, presence: true 
  validates :content, presence: true

  def flush_to_content
    puts "flushing>>>"
    p self.repairs

  	self.content = self.content.to_s
  end

  def repair_count
    repairs.count
  end
end
