require 'json'
class PdfForm < ActiveRecord::Base
  serialize :content, Hash
  belongs_to :customer, :class_name => "Customer", :foreign_key => 'Customer_id'
  before_validation :compact_keys
  validate :repair_count_within_limit, :on => :create
  has_many :repairs, dependent: :destroy  
  accepts_nested_attributes_for :repairs, :reject_if => lambda { |a| a[:instructions].blank? }, :allow_destroy => true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :file, FileUploader
  validates :content, presence: true
  validate :check_fields, :file_size

  def check_fields
    h = self.content

    if !h.key?("odo") or h["odo"].nil? or h["odo"].to_s.empty?
      errors.add(:odo, "field must be present")
    end  

    if !h.key?("original_estimate") or h["original_estimate"].nil? or  h["original_estimate"].to_s.empty?
      errors.add(:original_estimate, "field must be present")
    end  

    if !h.key?("invoice") or h["invoice"].nil? or h["invoice"].to_s.empty?
      errors.add(:invoice, "field must be present")
    end
  end

  def repair_count_within_limit
    if self.repairs.size >= 12
      errors.add(:base, "Exceeded repair limit")
    end
  end 

  def fill(customer)
    path = Rails.root.to_s + "/pyscripts/"
    puts "Filling pdf form...."
    puts "path #{path}"

    # gather all form fields into one hash
    format_content
    repairs_hash = {"Repairs" => []}
    self.repairs.each do |repair|
      repairs_hash["Repairs"].push(repair.attributes)
    end
    
    merged = self.content.merge(repairs_hash)

    # xxx omg future me im so sowwy

    # pass data to python in form of json
    File.open(path + "temp_dict.json","w") do |f|
      f.write(merged.to_json)
    end

    # run python script to create fdf and fill pdf
    system("cd #{path} && python2 fill.py") 
  end


  private
    def compact_keys
      self.content.delete_if { |k, v| (v.nil? or v.to_s.empty?) }
    end

    def format_content
      self.content.keys.each do |k|
          new_key = k.camelize
          if k == "license_plate"
            new_key = k.split("_")[0].camelize
          elsif k == "vin"
            new_key = k.upcase
          end
          self.content[new_key] = self.content[k]
          self.content.delete(k)
      end
    end

    # Validates the size of an uploaded file
    def file_size
      if file.size > 5.megabytes
        errors.add(:file, "should be less than 5MB")
      end
    end    
end
