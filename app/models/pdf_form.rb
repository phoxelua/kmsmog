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
  # after_save :fill
  
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

  def fill
    # pdf file not upload, proceed to auto fill with form data
    if self.file.blank?
      path = Rails.root.to_s + "/pyscripts/"
      puts "Filling pdf form...."
      puts "path #{path}"

      # gather all form fields into one hash
      formatted = format_content
      repairs_hash = {"Repairs" => []}
      self.repairs.each do |repair|
        repairs_hash["Repairs"].push(repair.attributes)
      end
      merged = formatted.merge(repairs_hash)

      # xxx omg future me im so sowwy
      # pass data to python in form of json
      File.open(path + "temp_dict.json","w") do |f|
        f.write(merged.to_json)
      end

      # run python script to create fdf and fill pdf
      puts "model.id #{self.id}"
      system("cd #{path} && python2 fill.py #{self.id}")

      # update file 
      src = File.join(Rails.root, "public/uploads/pdf_form/file/#{self.id}/test_new.pdf")
      p "src #{src}"
      p "self #{self}"
      src_file = File.new(src)
      p "file #{src_file}"
      p self.content
      self.update_attribute(:file, src_file)
      p "self #{self}"
      p self.content
    else
      puts "Fill uploaded no need to auto fill pdf."
      return true 
    end
  end


  private
    def compact_keys
      self.content.delete_if { |k, v| (v.nil? or v.to_s.empty?) }
    end

    def format_content
      formatted = {}
      self.content.keys.each do |k|
          new_key = k.camelize
          if k == "license_plate"
            new_key = k.split("_")[0].camelize
          elsif k == "vin"
            new_key = k.upcase
          end
          formatted[new_key] = self.content[k]
          # self.content.delete(k)
      end
      return formatted
    end

    # Validates the size of an uploaded file
    def file_size
      if file.size > 5.megabytes
        errors.add(:file, "should be less than 5MB")
      end
    end    
end
