class PdfForm < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer", :foreign_key => 'Customer_id'
  attr_accessor :formy
  serialize :formy, Hash
  before_validation :flush_to_content
  default_scope -> { order(created_at: :desc) }
  # validates :customer_id, presence: true 
  # validates :content, presence: true

  def formy
  	@formy = {}
	# ary = ["a", "b", "c"]
	# ary.each{|a| @formy[a] = 0}
	# return @formy
  end

  def flush_to_content
  	self.content = @formy.to_s
  	p self.customer
  	p @formy
  	p self.content
  	puts ".................."
  	# self.customer = s
  end

end
