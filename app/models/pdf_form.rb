class PdfForm < ActiveRecord::Base
  belongs_to :customer
  default_scope -> { order(created_at: :desc) }
  validates :customer_id, presence: true
  validates :content, presence: true
end
