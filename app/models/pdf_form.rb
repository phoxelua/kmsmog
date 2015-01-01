class PdfForm < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer", :foreign_key => 'Customer_id'
  # attr_accessor :content
  # serialize :content, JSON #not working for some fucking reason
  before_validation :flush_to_content
  default_scope -> { order(created_at: :desc) }
  # validates :customer_id, presence: true 
  validates :content, presence: true

  def flush_to_content
  	self.content = self.content.to_s
  end
end
