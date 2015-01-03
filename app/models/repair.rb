class Repair < ActiveRecord::Base
  belongs_to :pdf_form
  validates :instruction, presence: true, length: { maximum: 100 }
  validates :svc, presence: true
end
