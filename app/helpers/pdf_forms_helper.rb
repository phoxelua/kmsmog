module PdfFormsHelper
  # Returns the Gravatar for the given pdf.
  def pdf_gravatar_for(pdf, size=100)
    gravatar_id = Digest::MD5::hexdigest(pdf.content.to_s.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: pdf.content.to_s[2..10], class: "gravatar", size: size)
  end	
end
