class PdfForm < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer", :foreign_key => 'Customer_id'
  has_one :form
  serialize :form, Hash
  before_validation :flush_to_content
  default_scope -> { order(created_at: :desc) }
  # validates :customer_id, presence: true 
  # validates :content, presence: true

  def form
  	@form = {}
	# ary = ["a", "b", "c"]
	# ary.each{|a| @form[a] = 0}
	# return @form
  end

  def flush_to_content
  	self.content = @form.to_s
  	p self.customer
  	p @form
  	p self.content
  	puts ".................."
  	# self.customer = s
  end

end
