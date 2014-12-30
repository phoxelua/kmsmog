module CustomersHelper
  # Returns the Gravatar for the given customer.
  def customer_gravatar_for(customer, size=100)
    gravatar_id = Digest::MD5::hexdigest(customer.name.downcase + customer.phone + customer.license_plate)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: customer.name, class: "gravatar", size: size)
  end	
end
